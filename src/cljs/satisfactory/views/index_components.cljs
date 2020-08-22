(ns satisfactory.views.index-components
  (:require
   [kee-frame.core :as kf]
   [re-frame.core :as rf]))

(defn page
  []
  [:section.section>div.container>div.content
   (let [ids @(rf/subscribe [:component-ids])]
     [:div
      [:ul (map
            (fn [id]
              [:li {:key id} [:a {:href (str "/components/" id)} id]])
            ids)]])])
