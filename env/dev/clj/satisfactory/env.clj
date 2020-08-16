(ns satisfactory.env
  (:require
    [selmer.parser :as parser]
    [clojure.tools.logging :as log]
    [satisfactory.dev-middleware :refer [wrap-dev]]))

(def defaults
  {:init
   (fn []
     (parser/cache-off!)
     (log/info "\n-=[satisfactory started successfully using the development profile]=-"))
   :stop
   (fn []
     (log/info "\n-=[satisfactory has shut down successfully]=-"))
   :middleware wrap-dev})
