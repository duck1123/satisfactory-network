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
              (println (str (.getAbsolutePath file) " - " (slurp file)))
              (.delete file))))))
    (catch Exception e
      (println e))))
