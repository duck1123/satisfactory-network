(ns satisfactory.views.index-components
  (:require
   [cljs.pprint :as p]
   [kee-frame.core :as kf]
   [re-frame.core :as rf]
   [satisfactory.components :as c]
   [satisfactory.events.components :as e.components]))

(defn init-page
  [{:keys [db]} _]
  {:db (assoc db ::e.components/items [])
   :document/title "Index Components"
   :dispatch-n [[::e.components/do-fetch-index]]})

(kf/reg-event-fx ::init-page init-page)

(kf/reg-controller
 ::page-controller
 {:params (c/filter-page :index-components-page)
  :start [::init-page]})

(defn page
  []
  [:section.section>div.container>div.content
   (let [ids @(rf/subscribe [::e.components/ids])]
     [:div
      [:ul (map
            (fn [id]
              [:li {:key id}

               (let [item @(rf/subscribe [::e.components/item id])]

                 [:a {:href (str "/components/" id)} (if item (:nick item) id)])])
            ids)]])])
