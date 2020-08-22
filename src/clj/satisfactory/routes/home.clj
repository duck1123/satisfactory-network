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
  (layout/render "home.html"))

(defn home-routes []
  [""
   {:middleware [middleware/wrap-csrf
                 middleware/wrap-formats]}
   ["/" {:get home-page}]
   ["/components" {:get home-page}]
   ["/components/:id" {:get home-page}]

   ["/api/v1/components" {:get get-components}]
   ["/api/v1/components/:id" {:get get-component}]

   ["/docs" {:get (fn [_]
                    (-> (response/ok (-> "docs/docs.md" io/resource slurp))
                        (response/header "Content-Type" "text/plain; charset=utf-8")))}]])
