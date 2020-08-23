(ns satisfactory.routes.home
  (:require
   [clojure.java.io :as io]
   [manifold.deferred :as md]
   [puget.printer :as puget]
   [ring.util.response]
   [ring.util.http-response :as response]
   [satisfactory.actions.components :as a.components]
   [satisfactory.file-handler :as fh]
   [satisfactory.layout :as layout]
   [satisfactory.middleware :as middleware]
   [satisfactory.queue :as sq]
   [taoensso.timbre :as timbre]))

(defn home-page [request]
  (layout/render "home.html"))

(defn home-routes []
  [""
   {:middleware [middleware/wrap-csrf
                 middleware/wrap-formats]}
   ["/" {:get home-page}]
   ["/components" {:get home-page}]
   ["/components/:id" {:get home-page}]

   ["/api/v1/components" {:get a.components/index-handler}]
   ["/api/v1/components/:id" {:get a.components/read-handler}]

   ["/docs" {:get (fn [_]
                    (-> (response/ok (-> "docs/docs.md" io/resource slurp))
                        (response/header "Content-Type" "text/plain; charset=utf-8")))}]])
