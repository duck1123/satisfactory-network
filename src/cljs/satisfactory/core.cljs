(ns satisfactory.core
  (:require
   [com.smxemail.re-frame-cookie-fx]
   [day8.re-frame.http-fx]
    [kee-frame.core :as kf]
    [re-frame.core :as rf]
    [ajax.core :as http]
    [satisfactory.ajax :as ajax]
    [satisfactory.routing :as routing]
    [satisfactory.view :as view]))


(rf/reg-event-fx
  ::load-about-page
  (constantly nil))

(kf/reg-controller
  ::about-controller
  {:params (constantly true)
   :start  [::load-about-page]})

(rf/reg-sub
  :docs
  (fn [db _]
    (:docs db)))

(kf/reg-chain
  ::load-home-page
  (fn [_ _]
    {:http-xhrio {:method          :get
                  :uri             "/docs"
                  :response-format (http/raw-response-format)
                  :on-failure      [:common/set-error]}})
  (fn [{:keys [db]} [_ docs]]
    {:db (assoc db :docs docs)}))

(def sample-ids [])

;; (kf/reg-controller
;;   ::home-controller
;;   {:params (constantly true)
;;    :start  [::load-home-page]})

;; -------------------------
;; Initialize app
(defn mount-components
  ([] (mount-components true))
  ([debug?]
    (rf/clear-subscription-cache!)
    (kf/start! {:debug?         (boolean debug?)
                :routes         routing/routes
                :hash-routing?  true
                :initial-db     {:component-ids sample-ids}
                :root-component [view/root-component]})))

(defn init! [debug?]
  (ajax/load-interceptors!)
  (mount-components debug?))
