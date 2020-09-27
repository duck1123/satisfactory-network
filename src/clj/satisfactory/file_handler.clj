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
  (:import
   (java.io PushbackReader)
   (java.nio.charset StandardCharsets)
   (java.nio.file Files Path)
   (org.apache.commons.io FileUtils)))

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
  [_path data]
  (send-message! (get data "command")))

(defn handle-fallback
  [_path data]
  (timbre/info "Handle fallback")
  (handle-echo _path data))

(defn handle-ping
  [_path _lines]

  (send-message! "pong"))

(defn handle-get-component-response
  [_path data]
  (let [id (get data "id")
        info (dissoc data "command")]
    (dosync
     (alter sq/component-info assoc id info))))

(defn handle-get-components-response
  [_path data]
  (let [ids (get data "items")
        id "random-id"
        d (get @sq/pending-messages id)]
    (swap! sq/component-ids (constantly (sort ids)))
    (when d (md/success! d ids))))

(defn handle-get-info
  [_path _data]
  (timbre/info "get-info"))

(defn handle-panic
  [_path _data]
  (send-message! "panic"))

(defn handle-rick
  [_path _data]
  (send-message! "rick"))

(def handlers
  {"panic" handle-panic
   "rick" handle-rick
   "ping" handle-ping
   "get-component-response" handle-get-component-response
   "get-components-response" handle-get-components-response
   "get-info" handle-get-info})

(defn process-file!
  [^Path path]
  (timbre/info "processing file")
  (Thread/sleep 1000)
  (let [outbox-dir (env :outbox)
        file (io/file outbox-dir (str path))]
    (when (.isFile file)
      (let [name (.getName file)
            message (edn/read (PushbackReader. (io/reader file)
                                               #_(Files/newBufferedReader path StandardCharsets/UTF_8)))]
        (timbre/infof "Message: %s" message)
        (if-let [command (timbre/spy :info (get message "command"))]
          (do
            (timbre/infof "%s - %s" name  command)
            (let [handler (get handlers command handle-fallback)]
              (handler path message)))
          (do (timbre/error "Could not determine command")
              (puget/cprint message))))
      (Thread/sleep 1500)
      (.delete file))))


(defn process-messages!
  []
  (let [outbox-dir (env :outbox)
        files (file-seq (io/file outbox-dir))]
    (doseq [file files]
      (when (.isFile file)
        (let [message (edn/read (PushbackReader. (io/reader file)))]
          (timbre/infof "Message: %s" message)
          (if-let [command (timbre/spy :info (get message "command"))]
            (do
              (timbre/infof "%s - %s" (.getName file) command)
              (let [handler (get handlers command handle-fallback)]
                (handler file message)))
            (do (timbre/error "Could not determine command")
                (puget/cprint message))))
        (Thread/sleep 500)
        (.delete file)))))

(defn handle-event
  [event]
  (try
    (let [{:keys [types path]} (timbre/spy :info event)]
      (when (some (partial = :create) types)
        (process-file! path)
        ;; (let [f (io/file path)]
        ;;   (timbre/spy :info f)
        ;;   )

        (Thread/sleep 1000)

        #_(process-messages!)

        ))
    (catch Exception e
      (timbre/error e))))

(defn list-files
  []
  (let [c (env :computer)
        f (io/file c)]
    (file-seq f)))

(defn list-outbox
  []
  (let [outbox (env :outbox)
        f (io/file outbox)]
    (filter
     #(.isFile %)
     (file-seq f))))

(defn list-local-files
  []
  (let [f (io/file "/home/duck/projects/satisfactory-network/src/lua")]
    (file-seq f)))

(defn copy-files
  []
  (let [src-path "/home/duck/projects/satisfactory-network/src/lua"
        src (io/file src-path)
        dest (io/file (env :computer))]
    (doseq [f (list-local-files)]
      ;; (Thread/sleep 500)
      (when (not= (.getPath f) src-path)
        (let [name (.getName f)
              dest-name (io/file dest name)]
          (if (.isDirectory f)
            (do
              (.mkdirs dest-name)
              (Thread/sleep 500))
            (if (.exists f)
              (when (not (FileUtils/contentEquals
                        f dest-name))
                (timbre/infof "Updating file: %s" name)
                (io/copy f dest-name)
                (Thread/sleep 500))
              (do
                (timbre/infof "Creating file: %s" name)
                (io/copy f dest-name)
                (Thread/sleep 500)))))))

    #_(io/copy src dest)))
