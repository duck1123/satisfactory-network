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
    (let [item (get sq/sample-component-map id)]
      (if item
        (http/ok {:item item})
        (http/ok {:status "queued"})))))

(defn index-handler
  [_request]
  (let [d (md/deferred)
        id "random-id"]

    (swap! sq/component-ids (constantly sq/sample-ids))
    (http/ok {:items @sq/component-ids})))
