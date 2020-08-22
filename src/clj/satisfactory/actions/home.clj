(ns satisfactory.actions.home
  (:require
   [satisfactory.layout :as layout]))

(defn home-handler
  [_]
  (layout/render "home.html"))
