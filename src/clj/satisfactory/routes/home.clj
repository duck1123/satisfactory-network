(ns satisfactory.routes.home
  (:require
   [clojure.java.io :as io]
   [manifold.deferred :as md]
   [puget.printer :as puget]
   [ring.util.response]
   [ring.util.http-response :as response]
   [satisfactory.file-handler :as fh]
   [satisfactory.layout :as layout]
   [satisfactory.middleware :as middleware]
   [satisfactory.queue :as sq]
   [taoensso.timbre :as timbre]))

(defn home-page [request]
  (layout/render request "home.html"))

(defn get-components
  [request]
  (let [d (md/deferred)
        id "random-id"]
    (when (empty? @sq/component-ids)
      (swap! sq/pending-messages assoc id d)
      (fh/send-message! "get-components" {"id" id}))

    {:body @sq/component-ids}))

(defn get-component
  [request]
  (let [request-id "get-component-request"
        id (get-in request [:path-params :id])]
    (if-let [current-info (get @sq/component-info id)]
      (do
        (fh/send-request! "get-component" request-id {"id" id})
        {:body current-info})
      (do
        (fh/send-request! "get-component" request-id {"id" id})
        {:body {:status "queued"}}))))

(defn home-routes []
  [""
   {:middleware [middleware/wrap-csrf
                 middleware/wrap-formats]}
   ["/" {:get home-page}]
   ["/components" {:get get-components}]
   ["/components/:id" {:get get-component}]

   ["/docs" {:get (fn [_]
                    (-> (response/ok (-> "docs/docs.md" io/resource slurp))
                        (response/header "Content-Type" "text/plain; charset=utf-8")))}]])
