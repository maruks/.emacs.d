{:user 
 {:plugins [[cider/cider-nrepl "0.7.0-SNAPSHOT"]                  
            [speclj "2.5.0"]
            [lein-exec "0.3.4"]]

  :dependencies [[im.chit/iroh "0.1.11"]                                  
                 [im.chit/vinyasa "0.2.0"]
                 [leiningen #=(leiningen.core.main/leiningen-version)]
                 [spyscope "0.1.4"]
                 [difform "1.1.2"]
                 [org.clojars.gjahad/debug-repl "0.3.3"]
                 [clj-ns-browser "1.3.1"]
                 [org.clojure/tools.namespace "0.2.4"]]

  :injections [(require '[vinyasa.inject :as inj] 
                        'spyscope.core
                        'alex-and-georges.debug-repl
                        'com.georgejahad.difform
                        'clj-ns-browser.sdoc)

               (inj/inject 'clojure.core
                           '[[iroh.core delegate >ns >var .> .? .* .% .%>]])

               (inj/inject 'clojure.core '> 
                           '[[vinyasa.inject inject]
                             [vinyasa.pull pull]
                             [vinyasa.lein lein]
                             [vinyasa.reimport reimport]
                             [clojure.pprint pprint pp]
                             [clojure.repl doc source]
                             [alex-and-georges.debug-repl debug-repl]
                             [com.georgejahad.difform difform]
                             [clj-ns-browser.sdoc sdoc]])]}}



