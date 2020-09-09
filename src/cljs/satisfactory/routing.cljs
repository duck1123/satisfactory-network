(ns satisfactory.routing
  (:require
    [re-frame.core :as rf]))

(def api-routes
  [["/components"
    ["" :api-index-components]
    ["/:id" :api-show-component]]])

(def routes
  [["/" :index-components-page]
   ["/components/:id" :show-component-page]
   ["/about" :about]
   (into ["/api/v1"] api-routes)])

(rf/reg-sub
  :nav/route
  :<- [:kee-frame/route]
  identity)

(rf/reg-event-fx
  :nav/route-name
  (fn [_ [_ route-name]]
    {:navigate-to [route-name]}))

(rf/reg-sub
  :nav/page
  :<- [:nav/route]
  (fn [route _]
    (-> route :data :name)))
