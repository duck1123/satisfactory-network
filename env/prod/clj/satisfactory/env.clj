(ns satisfactory.env
  (:require [clojure.tools.logging :as log]))

(def defaults
  {:init
   (fn []
     (log/info "\n-=[satisfactory started successfully]=-"))
   :stop
   (fn []
     (log/info "\n-=[satisfactory has shut down successfully]=-"))
   :middleware identity})
