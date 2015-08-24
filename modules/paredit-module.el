;; paredit-module

(require 'package-module)

(package-require 'paredit)

(defun enable-paredit ()
  (paredit-mode 1))

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

;; (defun erlang-paredit ()
;;   (progn
;;     (define-key erlang-mode-map [?\(] 'paredit-open-parenthesis)
;;     (define-key erlang-mode-map [?\[] 'paredit-open-square)
;;     (define-key erlang-mode-map [?\{] 'paredit-open-curly)
;;     (define-key erlang-mode-map [?\)] 'paredit-close-parenthesis)
;;     (define-key erlang-mode-map [?\}] 'paredit-close-curly)
;;     (define-key erlang-mode-map [?\]] 'paredit-close-square)
;;     (set (make-local-variable 'paredit-space-for-delimiter-predicates)
;; 	 '((lambda (endp delimiter) nil)))))

;; (add-hook 'erlang-mode-hook
;; 	  (lambda ()
;; 	    (enable-paredit)
;; 	    (erlang-paredit)))

(provide 'paredit-module)
