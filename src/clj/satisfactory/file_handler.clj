(ns satisfactory.file-handler
  (:require
   [clojure.edn :as edn]
   [clojure.java.io :as io]
   [clojure.string :as string]
   [manifold.deferred :as md]
   [puget.printer :as puget]
   [satisfactory.config :refer [env]]
   [satisfactory.queue :as sq]
   [taoensso.timbre :as timbre])
  (:import (java.io PushbackReader)))

(defn format-table
  [data]
  (string/join
   "\n"
   ["{"
    (string/join
     "\n"
     (map
      (fn [[k v]]
        (if (string? v)
          (str k " = \"" v "\",")
          (str k " = \"ERROR\"")))
      data))
    "}"]))

(defn send-message!
  ([command]
   (send-message! command {}))
  ([command options]
   (let [inbox (io/file (env :inbox))
         _request-id (:request-id options)
         id (inst-ms (java.util.Date.))
         outfile (io/file inbox (str id ".txt"))
         record (format-table (assoc (dissoc options :request-id) "command" command))
         message (str "response = " record)]
     ;; (timbre/info message)
     (spit outfile message))))

(defn send-request!
  [command request-id args]
  (send-message!
   command
   (merge {:request-id request-id}  args)))

(defn handle-echo
  [_file data]
  (send-message! (get data "command")))

(defn handle-fallback
  [_file data]
  (timbre/info "Handle fallback")
  (handle-echo _file data))

(defn handle-ping
  [_file _lines]
  (send-message! "pong"))

(defn handle-get-component-response
  [_file data]
  (let [id (get data "id")
        info (dissoc data "command")]
    (dosync
     (alter sq/component-info assoc id info))))

(defn handle-get-components-response
  [_file data]
  (let [ids (get data "items")
        id "random-id"
        d (get @sq/pending-messages id)]
    (swap! sq/component-ids (constantly (sort ids)))
    (when d (md/success! d ids))))

(defn handle-get-info
  [_file _data]
  (timbre/info "get-info"))

(defn handle-panic
  [_file _data]
  (send-message! "panic"))

(def handlers
  {"panic" handle-panic
   "ping" handle-ping
   "get-component-response" handle-get-component-response
   "get-components-response" handle-get-components-response
   "get-info" handle-get-info})

(defn process-messages!
  []
  (let [outbox-dir (env :outbox)
        files (file-seq (io/file outbox-dir))]
    (doseq [file files]
      (when (.isFile file)
        (let [message (edn/read (PushbackReader. (io/reader file)))]
          (timbre/infof "Message: %s" message)
          (if-let [command (get message "command")]
            (do
              (timbre/infof "%s - %s" (.getName file) command)
              (let [handler (get handlers command handle-fallback)]
                (handler file message)))
            (do (timbre/error "Could not determine command")
                (puget/cprint message))))
        (.delete file)))))

(defn handle-event
  [event]
  (try
    (let [{:keys [types]} event]
      (when (some (partial = :create) types)
        (Thread/sleep 1000)
        (process-messages!)))
    (catch Exception e
      (timbre/error e))))

(defn list-files
  []
  (let [c (env :computer)
        f (io/file c)]
    (file-seq f)))

(defn list-local-files
  []
  (let [f (io/file "/home/duck/projects/satisfactory-network")]
    (file-seq f)))
