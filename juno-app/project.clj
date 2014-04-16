(defproject juno/juno-app "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [ring/ring-core "1.2.2"]
                 [ring/ring-jetty-adapter "1.2.2"]
                 [ring/ring-json "0.3.1"]
                 [ring/ring-anti-forgery "0.3.1"]
                 [compojure "1.1.6"]]
  :dev-dependencies [[ring/ring-devel "1.2.2"]]
  :main ^:skip-aot juno.juno-app
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
