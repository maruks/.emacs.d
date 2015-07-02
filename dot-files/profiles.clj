{:user
 {:plugins [[cider/cider-nrepl "0.9.1"]
            [speclj "3.3.0"]
            [refactor-nrepl "1.0.5"]
            [lein-exec "0.3.5"]]

  :dependencies [[leiningen #=(leiningen.core.main/leiningen-version)]
                 [im.chit/vinyasa "0.3.4"]
                 [spyscope "0.1.5"]
                 [io.aviso/pretty "0.1.18"]
                 [org.clojure/tools.namespace "0.2.11"]
                 [org.clojure/tools.nrepl "0.2.10"]]

  :signing {:gpg-key "D4FF9261"}        ; clojars signing key

;; Reflection macros: .> .? .* .% .%>

;; spyscope
;; #spy/p #spy/d #spy/t

  :injections [(require '[vinyasa.inject :as inject]
                        'spyscope.core
                        'io.aviso.repl)

               (inject/in

                ;; the default injected namespace is `.`
                [vinyasa.inject :refer [inject [in inject-in]]]
                [vinyasa.lein :exclude [*project*]]

                [vinyasa.pull pull]
                [cemerick.pomegranate add-classpath get-classpath resources]
                [clojure.pprint pprint]
                [clojure.java.shell sh]
                [clojure.tools.namespace.repl refresh]
                [clojure.repl apropos dir doc find-doc source pst [root-cause >cause]]
                [clojure.pprint pprint]

                ;; inject into clojure.core
                clojure.core
                [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var])]}}
