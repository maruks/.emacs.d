;; org-module

(require 'package-module)

(require 'ob)
(require 'ob-clojure)

(setq org-babel-clojure-backend 'cider)
(setq org-babel-lisp-eval-fn 'sly-eval)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (lisp . t)))

(provide 'org-module)
