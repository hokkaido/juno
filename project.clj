(defproject juno "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "https://github.com/hokkaido/juno"
  :license {:name "The MIT License"
            :url "http://opensource.org/licenses/MIT"}
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [juno-core "0.1.0-SNAPSHOT"]
                 [juno-app "0.1.0-SNAPSHOT"]]
  :dev-dependencies [[lein-light-nrepl "0.0.17"]]
  :plugins [[lein-sub "0.3.0"]]
  :sub ["juno-core"
        "juno-app"]
  :source-paths ["juno-core/src" "juno-app/src"]
  :repl-options {:nrepl-middleware [lighttable.nrepl.handler/lighttable-ops]}
  :main ^:skip-aot juno/juno-app.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
