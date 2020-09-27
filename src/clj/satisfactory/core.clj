(ns satisfactory.core
  (:require
   [satisfactory.file-handler :as fh]
   [satisfactory.handler :as handler]
   [satisfactory.nrepl :as nrepl]
   [luminus.http-server :as http]
   [satisfactory.config :refer [env]]
   [clojure.tools.cli :refer [parse-opts]]
   [clojure.tools.logging :as log]
   [mount.core :as mount]
   [taoensso.timbre :as timbre]
   [watch.man :as wm])
  (:gen-class))

;; log uncaught exceptions in threads
(Thread/setDefaultUncaughtExceptionHandler
 (reify Thread$UncaughtExceptionHandler
   (uncaughtException [_ thread ex]
     (log/error {:what :uncaught-exception
                 :exception ex
                 :where (str "Uncaught exception on" (.getName thread))}))))

(def cli-options
  [["-p" "--port PORT" "Port number"
    :parse-fn #(Integer/parseInt %)]])

(mount/defstate ^{:on-reload :noop} http-server
  :start
  (http/start
   (-> env
       (update :io-threads #(or % (* 2 (.availableProcessors (Runtime/getRuntime)))))
       (assoc  :handler (handler/app))
       (update :port #(or (-> env :options :port) %))))
  :stop
  (http/stop http-server))

(mount/defstate ^{:on-reload :noop} repl-server
  :start
  (when (env :nrepl-port)
    (nrepl/start {:bind (env :nrepl-bind)
                  :port (env :nrepl-port)}))
  :stop
  (when repl-server
    (nrepl/stop repl-server)))

(mount/defstate file-watcher
  :start
  (let [outbox (env :outbox)]
    (timbre/infof "starting watcher: %s" outbox)
    (try (wm/watch! outbox #'fh/handle-event)
         (catch Exception ex
           (timbre/error "Can't start watcher: " ex))))

  :stop
  (when file-watcher
    (timbre/info "stopping watcher")
    (wm/close file-watcher)))

(defn stop-app []
  (doseq [component (:stopped (mount/stop))]
    (log/info component "stopped"))
  (shutdown-agents))

(defn start-app [args]
  (doseq [component (-> args
                        (parse-opts cli-options)
                        mount/start-with-args
                        :started)]
    (log/info component "started"))
  (.addShutdownHook (Runtime/getRuntime) (Thread. stop-app)))

(defn -main [& args]
  (start-app args))
