(ns satisfactory.queue
  (:require
   [clojure.java.io :as io]
   [manifold.deferred :as d]))

(defonce pending-messages (atom {}))

(defonce component-ids (atom []))

(defonce component-info (ref {}))
