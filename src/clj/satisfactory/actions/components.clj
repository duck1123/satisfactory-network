(ns satisfactory.actions.components
  (:require
   [clojure.java.io :as io]
   [manifold.deferred :as md]
   [puget.printer :as puget]
   [ring.util.http-response :as http]
   [satisfactory.file-handler :as fh]
   [satisfactory.queue :as sq]
   [taoensso.timbre :as timbre]))


(defn read-handler
  [request]
  (let [request-id "get-component-request"
        id (get-in request [:path-params :id])]
    (if-let [current-info (get @sq/component-info id)]
      (do
        (fh/send-request! "get-component" request-id {"id" id})
        (http/ok current-info))
      (do
        (fh/send-request! "get-component" request-id {"id" id})
        (http/ok {:status "queued"})))))

(defn index-handler
  [request]
  (let [d (md/deferred)
        id "random-id"]
    (when (empty? @sq/component-ids)
      (swap! sq/pending-messages assoc id d)
      (fh/send-message! "get-components" {"id" id}))

    (http/ok @sq/component-ids)))
