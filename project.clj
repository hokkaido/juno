(defproject juno/juno-app "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "https://github.com/hokkaido/juno"
  :license {:name "The MIT License"
            :url "http://opensource.org/licenses/MIT"}
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [org.clojure/tools.cli "0.3.1"]
                 [ring/ring-core "1.2.2"]
                 [ring/ring-jetty-adapter "1.2.2"]
                 [ring/ring-json "0.3.1"]
                 [ring/ring-anti-forgery "0.3.1"]
                 [compojure "1.1.6"]]
  :dev-dependencies [[ring/ring-devel "1.2.2"] [lein-light-nrepl "0.0.17"]]
  :repl-options {:nrepl-middleware [lighttable.nrepl.handler/lighttable-ops]}
  :main ^:skip-aot juno.app
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
