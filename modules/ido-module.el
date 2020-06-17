;; ido-module

(require 'package-module)

(package-require 'flx-ido)

;; ido
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".clj" ".cljs" ".erl" ".hs" ".js" ".java" ".html" ".xml" ".sh" ".el" ".erl"))

(setq ido-use-faces nil)
;(setq flx-ido-use-faces nil)

(ido-mode 1)
(flx-ido-mode 1)

(provide 'ido-module)
