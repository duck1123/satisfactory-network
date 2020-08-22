(ns satisfactory.view
  (:require
    [kee-frame.core :as kf]
    [markdown.core :refer [md->html]]
    [reagent.core :as r]
    [re-frame.core :as rf]
    [satisfactory.views.index-components :as v.index-components]
    [satisfactory.views.show-component :as v.show-component]
    ))

(defn nav-link [title page]
  [:a.navbar-item
   {:href   (kf/path-for [page])
    :class (when (= page @(rf/subscribe [:nav/page])) "is-active")}
   title])

(defn navbar []
  (r/with-let [expanded? (r/atom false)]
    [:nav.navbar.is-info>div.container
     [:div.navbar-brand
      [:a.navbar-item {:href "/" :style {:font-weight :bold}} "satisfactory"]
      [:span.navbar-burger.burger
       {:data-target :nav-menu
        :on-click #(swap! expanded? not)
        :class (when @expanded? :is-active)}
       [:span][:span][:span]]]
     [:div#nav-menu.navbar-menu
      {:class (when @expanded? :is-active)}
      [:div.navbar-start
       [nav-link "Home" :home]
       [nav-link "About" :about]]]]))

(defn about-page []
  [:section.section>div.container>div.content
   [:img {:src "/img/warning_clojure.png"}]])

(rf/reg-sub :component-ids (fn [db _] (get db :component-ids)))

;; (defn home-page []
;;   [:section.section>div.container>div.content
;;    (let [ids @(rf/subscribe [:component-ids])]
;;      [:div
;;       [:ul (map
;;             (fn [id]
;;               [:li {:key id} [:a {:href (str "/components/" id)} id]])
;;             ids)]])])

(rf/reg-sub :component-id (fn [db [_ id]] id #_(get db id)))

(defn show-component
  [a]
  (println a)
  )

(defn root-component []
  [:div
   [navbar]
   [kf/switch-route (fn [route] (get-in route [:data :name]))
    :home v.index-components/page
    :show-component v.show-component/page
    :about about-page
    nil [:div ""]]])
