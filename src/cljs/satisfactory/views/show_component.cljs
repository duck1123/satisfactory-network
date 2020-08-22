(ns satisfactory.views.show-component
  (:require
   [kee-frame.core :as kf]
   [re-frame.core :as rf]))

(defn page
  [{{:keys [id]} :path-params}]
  (let [info @(rf/subscribe [:component-id id])]
    [:section.section>div.container>div.content
     [:p "Show Component: " id]
     [:button.button
      {:on-click (fn [e] (.log js/console e))}
      (str "Fetch " info)]
     [:a {:href (str "/api/v1/components/" id)} "json"]]))
