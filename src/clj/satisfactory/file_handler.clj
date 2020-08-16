(ns satisfactory.file-handler)

(defn handle-event
  [event]
  (println (pr-str event))
  (let [{:keys [types]} event]
    (if (some (partial = :modify) types)
      (println "modify")
      )
    )
  )
