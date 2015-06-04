;; lisp-module

(require 'package-module)

(package-require 'slime)
(package-require 'slime-company)

(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-asdf slime-sbcl-exts slime-company))

(provide 'lisp-module)
