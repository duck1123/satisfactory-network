(ns satisfactory.file-handler
  (:require
   [clojure.java.io :as io]
   [satisfactory.config :refer [env]]))

(defn send-message!
  [message]
  (let [inbox (io/file (env :inbox))
        id (inst-ms (java.util.Date.))
        outfile (io/file inbox (str id ".txt"))]
    (spit outfile message)))

(defn handle-echo
  [_file message]
  (send-message! message))

(defn handle-ping
  [_file _message]
  (send-message! "pong"))

(def handlers
  {"ping" handle-ping}
  )

(defn process-messages!
  []
  (let [outbox-dir (env :outbox)
        files (file-seq (io/file outbox-dir))]
    (doseq [file files]
      (when (.isFile file)
        (let [message (slurp file)]
          (println (str (.getName file) " - " message))
          (let [handler (get handlers message handle-echo)]
            (handler file message)))
        (.delete file)))))

(defn handle-event
  [event]
  (try
    (let [{:keys [types]} event]
      (when (some (partial = :create) types)
        (Thread/sleep 1000)
        (process-messages!)))
    (catch Exception e
      (println e))))
