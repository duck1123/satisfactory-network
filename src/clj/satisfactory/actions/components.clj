(ns satisfactory.actions.components
  (:require
   ;; [clojure.set :as set]
   ;; [clojure.spec.alpha :as s]
   ;; [expound.alpha :as expound]
   ;; [dinsro.model.categories :as m.categories]
   ;; [dinsro.spec.categories :as s.categories]
   ;; [dinsro.spec.actions.categories :as s.a.categories]
   ;; [dinsro.utils :as utils]
   [ring.util.http-response :as http]
   [taoensso.timbre :as timbre]

   )

  )


(defn read-handler
  [_]
  #_{:body "ok"}
  (http/ok {:status "ok"})
  )

(defn index-handler
  [_]
  (http/ok {:status "ok"})
  #_{:body "ok"}
  )
