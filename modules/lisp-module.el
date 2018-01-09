;; lisp-module

(require 'package-module)

(package-require 'slime)
(package-require 'slime-company)

(setq inferior-lisp-program "sbcl")

(eval-after-load 'lisp-mode
  '(progn
     (slime-setup '(slime-fancy slime-asdf slime-sbcl-exts slime-company))
     (define-key lisp-mode-map [?\s-c] 'slime-compile-and-load-file)
     (define-key lisp-mode-map (kbd "<f10>") 'slime-compile-and-load-file)
     (define-key lisp-mode-map (kbd "<f11>") 'slime)
     (define-key lisp-mode-map (kbd "<f12>") 'slime-selector)
     (advice-add 'slime-compile-and-load-file :before #'save-current-buffer-if-modified)))

(provide 'lisp-module)
