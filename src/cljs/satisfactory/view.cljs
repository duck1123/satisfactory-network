(ns satisfactory.view
  (:require
    [kee-frame.core :as kf]
    [markdown.core :refer [md->html]]
    [reagent.core :as r]
    [re-frame.core :as rf]))

(def sample-ids (sort ["12164ED44F7E14A548935CBB0FA7FF6D","E01184684657F94603C68AB3D2DA0DDC","FAAB9D6E4E5AC5449E6565B751AFF9A1","96482685425DE5D39A6862BFD4E9D0BB","93331AD848E087108D885B9966808D9E","CD965D9D4838A95D5A3E509F962CB565","6EB1A32C4CB7A331A1330B931152249C","BBD7267948EDA66FAE13678C1BFD1421","51FC54CC4647AC2EE255178FE850AD3C","148F6D4542B309BC461141A621350803","03EA52734F28F3640AB020939F56381E","6CB7A6704FC217A24588FA83E3F24F47","B42E2B5F434CADD7A89DB7A3CB3177A7","172E208247AF6A4B655F78961EB6BCEB","9F7118DA4401A591BB1F21B29BFC39D1","5DAE03C744076D52D7BA138D3A98FEA1","D71ED6D54F6D9DC705D380BD19E4D34F","633DB38D4E44E11C7EC760B31AB98A2E","BE2AFFD84D055C842BDCDBB658E7440E","DA93CF4F4DC76AA6815C72ABE0FEFF01","39002A9041DC5E70AA42728795595C66","B40B97D8430DF848A34473BB4687CCE0","8F85975B4E8459224C65D787202B554A","0556206E48BA9C739D598EB71008B2CB","FA75A62F4FFA521CD9515C846273241B","91B9C4DE43A7E54B0B1499A180A1918F","CCAB02D9441F2A2CCF42FAA698AF8C0A","A364C40443FFEABAA3B8AD94BD67EFA6","3356F3C848F3544EE89074A5BE6A175E","EBBBBD6F4288C254D0697B91BED93EC8","165467A24CC5BFA8FC8B33B283396EF0","CC403DE8418A53089E1EE7A5B3B8AFBB","87AB9F5A4BD4EFCF1208D8A9B6085420","90468E034FCEC86A04F69DA6A4FBB2FE","FB9EB7F5409EE02CD3C13D9094BF57DD","306133BC47DC4FD490E70B855B793D40","6438969047907ED5B4D457A0C7F9846D","C813B3AD42D6994E65BBFE994E26220E","91A395974BEA70148C9A49A0A4449E06","CE9B96EB4BBDB870DCBA3198DDED1750","67E1743E4FCD033EC6F73F95FE3E1531","3B2F706C48B63ADE0F99B6B29466CF22","819312A643B36FA11ACD32814BD417FB","71674EF746DF7C2FBA4D3AB6CACACAF8","220954F1420AC0D0D5BA138848D272BD","5E7971EE464911F98258D89694BD84F4","95614C8641349210FF8682BB7A9783BE","F16835D140C3DDACC0CECBB66C36CED0","3571FDDA45EA9D1238A88DBCC001B506","9A76E21A48FFCED4312F42BDA4A24972","F3E2B0E145C8B13D8CC605B7F57C2C61","0C2A83674E98BD7C72847AA8B488F9BF","86AA37014D5B0FF9645F25B93CE98CBE","ECEBAF0D480B369CFBA8D587A51F793C","2668BF8A4E3A531D964FCDAFD08C6ADE","D2CEA9114337526F0C032FA0BE8B1BBB","770C6CB84D30FBEB03F75EBE790B876B"]))

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

(defn home-page []
  [:section.section>div.container>div.content
   (let [ids sample-ids]
     [:div
      [:ul (map
            (fn [id]
              [:li {:key id} [:a {:href (str "/components/" id)} id]])
            sample-ids)]
     ])])

(rf/reg-sub :component (fn [_ [_ id]] id))

(defn show-component
  [a]
  (println a)
  (let [id (get-in a [:path-params :id])
        info @(rf/subscribe [:component id])]
    [:section.section>div.container>div.content
     [:p "Show Component: " id]
     [:button.button
      {:on-click (fn [e] (.log js/console e))}
      (str "Fetch " info)]
     [:a {:href (str "/api/v1/components/" id)} "json"]
     ]))

(defn root-component []
  [:div
   [navbar]
   [kf/switch-route (fn [route] (get-in route [:data :name]))
    :home home-page
    :show-component show-component
    :about about-page
    nil [:div ""]]])
