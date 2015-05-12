{:user 
 {:plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]                  
            [speclj "2.5.0"]
            [refactor-nrepl "1.0.1"]
            [lein-exec "0.3.4"]]

  :dependencies [[im.chit/iroh "0.1.11"]                                  
                 [im.chit/vinyasa "0.2.2"]
                 [leiningen "2.5.0"]
                 [spyscope "0.1.4"]
                 [difform "1.1.2"]
                 [criterium "0.4.3"]
                 [org.clojars.gjahad/debug-repl "0.3.3"]
                 [io.aviso/pretty "0.1.8"]
                 [org.clojure/tools.namespace "0.2.4"]
                 [org.clojure/tools.nrepl "0.2.7"]]

  :signing {:gpg-key "D4FF9261"}        ; clojars signing key
  
;; Reflection macros: .> .? .* .% .%> 
  
;; criterium
;; (bench (Thread/sleep 1000) :verbose)
;; (with-progress-reporting (bench (Thread/sleep 1000) :verbose))
;; (report-result (benchmark (Thread/sleep 1000)) :verbose)
;; (report-result (quick-bench (Thread/sleep 1000)))

;; spyscope
;; #spy/p #spy/d #spy/t

  :injections [(require '[vinyasa.inject :as inject] 
                        'spyscope.core
                        'criterium.core
                        'alex-and-georges.debug-repl
                        'com.georgejahad.difform
                        'io.aviso.repl)

               (inject/in 

                ;; the default injected namespace is `.` 
             
                [vinyasa.inject inject]
                [vinyasa.pull pull]
                [vinyasa.lein lein]
                [vinyasa.reimport reimport]
                [criterium.core with-progress-reporting report-result bench quick-bench benchmark]
                            
                clojure.core
                [iroh.core .> .? .* .% .%>]        
                [alex-and-georges.debug-repl debug-repl]

                clojure.core >
                [cemerick.pomegranate add-classpath get-classpath resources]
                [clojure.tools.namespace.repl refresh]
                [clojure.repl apropos dir doc find-doc source pst [root-cause >cause]]
                [clojure.pprint pprint]
                [com.georgejahad.difform difform]
                [clojure.java.shell sh])]}}
