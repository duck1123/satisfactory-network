(ns satisfactory.actions.components
  (:require
   [manifold.deferred :as md]
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
  [_request]
  (let [d (md/deferred)
        id "random-id"]

    (swap! sq/component-ids (constantly sq/sample-ids))
    (http/ok {:items @sq/component-ids})))
