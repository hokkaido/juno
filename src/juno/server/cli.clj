(ns juno.server.cli
  (:require [clojure.string :as string]
  	        [juno.server.app :as app]
  	        [clojure.java.io :as io]
            [clojure.tools.cli :refer [parse-opts]])
  (:import (java.net InetAddress))
  (:gen-class))

(def cli-options
  [["-c" "--config" "/path/to/config/file in edn format"]
   ["-p" "--port PORT" "Port number"
    :default 8080
    :parse-fn #(Integer/parseInt %)
    :validate [#(< 0 % 0x10000) "Must be a number between 0 and 65536"]]
   ["-l" "--listen HOST" "Remote host"
    :default (InetAddress/getByName "localhost")
    :default-desc "localhost"
    :parse-fn #(InetAddress/getByName %)]    
   [nil "--db-host DB-HOST" "Host of the postgres server"
    :default (InetAddress/getByName "localhost")
    :default-desc "localhost"
    :parse-fn #(InetAddress/getByName %)]    
   [nil "--db-port DB-PORT" "Port of the postgres server"
    :default 5432
    :parse-fn #(Integer/parseInt %)
    :validate [#(< 0 % 0x10000) "Must be a number between 0 and 65536"]]   
   ["-h" "--help"]])

(defn usage [options-summary]
  (->> ["Juno 0.1.0-SNAPSHOT - I feel fine. How about you?"
        ""
        "Usage: juno.jar [options] action"
        ""
        "Options:"
        options-summary
        ""
        "Actions:"
        "  start    Start the server"
        "  stop     Stop an existing server"
        "  restart  Restart the server"
        ""
        "Please refer to the manual page for more information."]
       (string/join \newline)))


(defn error-msg [errors]
  (str "The following errors occurred while parsing your command:\n\n"
       (string/join \newline errors)))

(defn exit [status msg]
  (println msg)
  (System/exit status))

(defn juno-version []
  (or (System/getenv "JUNO_VERSION")
      (with-open [reader (-> "META-INF/maven/juno/juno/pom.properties"
                             io/resource
                             io/reader)]
        (-> (doto (java.util.Properties.)
              (.load reader))
            (.getProperty "version")))))


(defn -main [& args]
  (let [{:keys [options arguments errors summary]} (parse-opts args cli-options)]
    ;; Handle help and error conditions
    (cond
      (:help options) (exit 0 (usage summary))
      (not= (count arguments) 1) (exit 1 (usage summary))
      errors (exit 1 (error-msg errors)))
    ;; Execute program with options
    (case (first arguments)
      "start" (app/start! options)
      "stop" (app/stop! options)
      "restart" (app/restart! options)
      (exit 1 (usage summary)))))

