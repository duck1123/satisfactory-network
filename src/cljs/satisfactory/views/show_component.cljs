(ns satisfactory.views.show-component
  (:require
   [cljs.pprint :as p]
   [kee-frame.core :as kf]
   [re-frame.core :as rf]
   [satisfactory.components :as c]
   [satisfactory.events.components :as e.components]))

(defn init-page
  [_ [{:keys [id]}]]
  {:dispatch-n [
                [::e.components/do-fetch-record id]
                ;; [::e.rates/do-fetch-rate-feed-by-currency (int id)]
                ;; [::e.users/do-fetch-index]
                ;; [::e.accounts/do-fetch-index]

                ]
   :document/title "Show Currency"})

;; (s/fdef init-page
;;   :args (s/cat :cofx ::s.v.show-currency/init-page-cofx
;;                :event ::s.v.show-currency/init-page-event)
;;   :ret ::s.v.show-currency/init-page-response)

(kf/reg-event-fx ::init-page init-page)

(kf/reg-controller
 ::page-controller
 {:params (c/filter-param-page :show-component-page)
  :start  [::init-page]})

(defn page
  [{{:keys [id]} :path-params}]
  (let [item @(rf/subscribe [::e.components/item id])
        nick (:nick item)]
    [:section.section>div.container>div.content
     [:p "Show Component: " id]

     [:pre (with-out-str (p/pprint item))]
     [:p "Nick: " nick]
     [:ul (map
           (fn [type] [:li {:key type}
                     [:p type]
                     ])
           (:types item))]
     [:p "Standby: " (str (:standby item))]
     [:p "Potential: " (str (* (:potential item) 100) "%")]
     [:p "Power Consumption: " (:powerConsumProducing item)]
     [:button.button
      {:on-click (fn [e] (.log js/console e))}
      (str "Fetch " nick)]
     [:a {:href (str "/api/v1/components/" id)} "json"]]))
