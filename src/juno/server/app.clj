(ns juno.server.app
  (:require [compojure.core :refer [defroutes]]
            [ring.adapter.jetty :as ring]
            [compojure.route :as route]
            [compojure.handler :as handler]
            [compojure.core :refer :all]))

(defroutes app-routes
  (GET "/" [] "Hello World")
  (route/not-found "404 Page Not Found"))

(def app-handler
  (handler/site app-routes))

(defn start!
  "Start juno with the given options"
  [options]
  (ring/run-jetty app-handler {:port (:port options)
                               :join? false}))

(defn stop!
  "Stop juno"
  [options]
  (ring/run-jetty app-handler {:port (:port options)
                               :join? false}))

(defn restart!
  "Restart juno with the given options"
  [options]
  (ring/run-jetty app-handler {:port (:port options)
                               :join? false}))