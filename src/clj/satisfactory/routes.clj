(ns satisfactory.routes
(:require
   ;; [dinsro.actions.accounts :as a.accounts]
   ;; [dinsro.actions.admin-accounts :as a.admin-accounts]
   ;; [dinsro.actions.admin-categories :as a.admin-categories]
   ;; [dinsro.actions.admin-currencies :as a.admin-currencies]
   ;; [dinsro.actions.admin-rate-sources :as a.admin-rate-sources]
   ;; [dinsro.actions.admin-rates :as a.admin-rates]
   ;; [dinsro.actions.admin-transactions :as a.admin-transactions]
   ;; [dinsro.actions.admin-users :as a.admin-users]
   ;; [dinsro.actions.authentication :as a.authentication]
 [satisfactory.actions.components :as a.components]
   ;; [dinsro.actions.currencies :as a.currencies]
 [satisfactory.actions.home :as a.home]
 [satisfactory.middleware :as middleware]
   ;; [dinsro.actions.rate-sources :as a.rate-sources]
   ;; [dinsro.actions.rates :as a.rates]
   ;; [dinsro.actions.settings :as a.settings]
   ;; [dinsro.actions.status :as a.status]
   ;; [dinsro.actions.transactions :as a.transactions]
   ;; [dinsro.actions.users :as a.users]
   ;; [dinsro.actions.websocket :as a.websocket]
   ;; [dinsro.middleware :as middleware]
   ;; [taoensso.timbre :as timbre]

   )

  )


(def view-mappings
  [
   "/"
   "/components"
   "/components/:id"
   ;; "/about"
   ;; "/accounts"
   ;; "/accounts/:id"
   ;; "/admin"
   ;; "/categories"
   ;; "/categories/:id"
   ;; "/currencies"
   ;; "/currencies/:id"
   ;; "/login"
   ;; "/rate-sources"
   ;; "/rate-sources/:id"
   ;; "/rates"
   ;; "/rates/:id"
   ;; "/register"
   ;; "/settings"
   ;; "/transactions"
   ;; "/users"
   ;; "/users/:id"

   ])

(def handler-mappings
  {
   ;; :api-index-accounts #'a.accounts/index-handler
   ;; :api-create-account #'a.accounts/create-handler
   ;; :api-read-account   #'a.accounts/read-handler
   ;; :api-delete-account #'a.accounts/delete-handler

   })

(def admin-routes
  [
   ;; ["/accounts"
   ;;  [""                {:post   a.admin-accounts/create-handler
   ;;                      :get    a.admin-accounts/index-handler}]
   ;;  ["/:id"            {:get    a.admin-accounts/read-handler
   ;;                      :delete a.admin-accounts/delete-handler}]]
   ;; ["/categories"
   ;;  [""                {:get    a.admin-categories/index-handler
   ;;                      :post   a.admin-categories/create-handler}]
   ;;  ["/:id"            {:get    a.admin-categories/read-handler
   ;;                      :delete a.admin-categories/delete-handler}]]
   ;; ["/currencies"
   ;;  [""                {:get    a.admin-currencies/index-handler
   ;;                      :post   a.admin-currencies/create-handler}]
   ;;  ["/:id"            {:delete a.admin-currencies/delete-handler
   ;;                      :get    a.admin-currencies/read-handler}]]
   ;; ["/rate-sources"
   ;;  [""                {:get    a.admin-rate-sources/index-handler
   ;;                      :post   a.admin-rate-sources/create-handler}]
   ;;  ["/:id"            {:get    a.admin-rate-sources/read-handler
   ;;                      :delete a.admin-rate-sources/delete-handler}]]
   ;; ["/rates"
   ;;  [""                {:get    a.admin-rates/index-handler
   ;;                      :post   a.admin-rates/create-handler}]
   ;;  ["/:id"            {:get    a.admin-rates/read-handler
   ;;                      :delete a.admin-rates/delete-handler}]]
   ;; ["/transactions"
   ;;  [""                {:get    a.admin-transactions/index-handler
   ;;                      :post   a.admin-transactions/create-handler}]
   ;;  ["/:id"            {:get    a.admin-transactions/read-handler
   ;;                      :delete a.admin-transactions/delete-handler}]]
   ;; ["/users"
   ;;  [""                {:get    a.admin-users/index-handler
   ;;                      :post   a.admin-users/create-handler}]
   ;;  ["/:id"            {:get    a.admin-users/read-handler
   ;;                      :delete a.admin-users/delete-handler}]]

   ])

(def model-routes
  [

   ;; ["/accounts"
   ;;  [""                {:post   a.accounts/create-handler
   ;;                      :get    a.accounts/index-handler}]
   ;;  ["/:id"
   ;;   [""               {:get    a.accounts/read-handler
   ;;                      :delete a.accounts/delete-handler}]
   ;;   ["/currencies"    {:get    a.currencies/index-by-account-handler}]]]
   ["/components"
    [""                {:get    a.components/index-handler
                        ;; :post   a.components/create-handler

                        }]
    ["/:id"
     [""               {:get    a.components/read-handler
                        ;; :delete a.components/delete-handler

                        }]
     ;; ["/accounts"      {:get    a.accounts/index-by-category-handler}]
     ;; ["/rates"         {:get    a.rates/index-by-category-handler}]

     ]]
   ;; ["/currencies"
   ;;  [""                {:get    a.currencies/index-handler
   ;;                      :post   a.currencies/create-handler}]
   ;;  ["/:id"
   ;;   [""               {:delete a.currencies/delete-handler
   ;;                      :get    a.currencies/read-handler}]
   ;;   ["/accounts"      {:get    a.accounts/index-by-currency-handler}]
   ;;   ["/rates"         {:get    a.rates/index-by-currency-handler}]]]
   ;; ["/rate-sources"
   ;;  [""                {:get    a.rate-sources/index-handler
   ;;                      :post   a.rate-sources/create-handler}]
   ;;  ["/:id"
   ;;   [""               {:get    a.rate-sources/read-handler
   ;;                      :delete a.rate-sources/delete-handler}]
   ;;   ["/run"           {:post   a.rate-sources/run-handler}]]]
   ;; ["/rates"
   ;;  [""                {:get    a.rates/index-handler
   ;;                      :post   a.rates/create-handler}]
   ;;  ["/:id"            {:get    a.rates/read-handler
   ;;                      :delete a.rates/delete-handler}]]
   ;; ["/transactions"
   ;;  [""                {:get    a.transactions/index-handler
   ;;                      :post   a.transactions/create-handler}]
   ;;  ["/:id"            {:get    a.transactions/read-handler
   ;;                      :delete a.transactions/delete-handler}]]
   ;; ["/users"
   ;;  [""                {:get    a.users/index-handler
   ;;                      :post   a.users/create-handler}]
   ;;  ["/:id"            {:get    a.users/read-handler
                        ;; :delete a.users/delete-handler}]]
   ]

  )

(def routes
  [

   (into [""] (map (fn [path] [path {:get a.home/home-handler}]) view-mappings))
   ;; ["/ws" a.websocket/ws-handler]
   ["/api/v1"
    {:middleware [middleware/wrap-formats]}
    (into [""       #_{:middleware [middleware/wrap-restricted]}] model-routes)
    (into ["/admin" #_{:middleware [middleware/wrap-restricted]}] admin-routes)

    ;; ["/authenticate" {:post a.authentication/authenticate-handler}]
    ;; ["/logout"       {:post a.authentication/logout-handler}]
    ;; ["/register"     {:post a.authentication/register-handler}]
    ;; ["/settings"     {:get  a.settings/settings-handler}]
    ;; ["/status"       {:get  a.status/status-handler}]

    ]

   ])
