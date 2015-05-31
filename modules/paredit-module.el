;; paredit-module

(require 'package-module)

(package-require 'paredit)

(defun enable-paredit () 
  (paredit-mode 1)
  (prettify-symbols-mode 1))

(defvar lisp-mode-hooks
  '(clojure-mode-hook
    cider-repl-mode-hook
    slime-repl-mode-hook
    emacs-lisp-mode-hook
    ielm-mode-hook
    lisp-mode-hook
    lisp-interaction-mode-hook
    geiser-repl-mode-hook
    scheme-mode-hook))

(dolist (h lisp-mode-hooks)
  (add-hook h 'enable-paredit))

(provide 'paredit-module)
