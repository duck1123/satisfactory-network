(ns satisfactory.file-handler
  (:require
   [clojure.java.io :as io]
   [satisfactory.config :refer [env]]))

(defn handle-event
  [event]
  (try
    (let [{:keys [types]} event]
      (when (some (partial = :create) types)
        (Thread/sleep 1000)
        (let [outbox-dir (env :outbox2)
              files (file-seq (io/file outbox-dir))]
          (doseq [file files]
            (when (.isFile file)
              (let [message (slurp file)]
                (println (str (.getName file) " - " message))

                (let [inbox (io/file (env :inbox))
                      id (inst-ms (java.util.Date.))
                      outfile (io/file inbox (str id ".txt"))]
                  (if (= message "ping")
                    (spit outfile "pong")
                    (spit outfile (str "ECHO: " message)))))
              (.delete file))))))
    (catch Exception e
      (println e))))
