;; smartparens-module

(require 'package-module)

(package-require 'smartparens)

(require 'smartparens-config)

(add-hook 'clojure-mode-hook (lambda ()
			       (require 'smartparens-clojure)
			       (smartparens-strict-mode 1)))

(add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
(add-hook 'lisp-mode-hook       #'smartparens-strict-mode)
(add-hook 'scheme-mode-hook     #'smartparens-strict-mode)
(add-hook 'ielm-mode-hook       #'smartparens-mode)

(add-hook 'cider-repl-mode-hook #'smartparens-mode)
(add-hook 'slime-repl-mode-hook #'smartparens-mode)
(add-hook 'lisp-interaction-mode-hook #'smartparens-mode)
(add-hook 'geiser-repl-mode-hook #'smartparens-mode)

(add-hook 'js-mode-hook #'smartparens-mode)

(add-hook 'erlang-mode-hook (lambda ()
			      (electric-pair-mode -1)
			      (show-paren-mode -1)
			      (smartparens-mode 1)
			      (show-smartparens-mode 1)))

(add-hook 'erlang-shell-mode-hook #'smartparens-mode)

(add-hook 'elixir-mode-hook (lambda ()
			      (require 'smartparens-elixir)
			      (smartparens-mode 1)))

(add-hook 'html-mode-hook #'smartparens-mode)
(add-hook 'lua-mode-hook #'smartparens-mode)
(add-hook 'ruby-mode-hook #'smartparens-mode)
(add-hook 'rust-mode-hook #'smartparens-mode)

;; erlang

(sp-with-modes '(erlang-mode erlang-shell-mode)
  (sp-local-pair "<<" ">>"))

;; keybindings

(sp-use-smartparens-bindings)

(define-key smartparens-mode-map (kbd "M-s") 'sp-splice-sexp)
(define-key smartparens-mode-map (kbd "M-r") 'sp-raise-sexp)
(define-key smartparens-mode-map (kbd "M-j") 'sp-join-sexp)
(define-key smartparens-mode-map (kbd "M-D") 'sp-absorb-sexp)
(define-key smartparens-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
(define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)

(define-key smartparens-mode-map (kbd "s-[") 'sp-select-previous-thing)
(define-key smartparens-mode-map (kbd "s-{") 'sp-select-previous-thing-exchange)

(define-key smartparens-mode-map (kbd "s-]") 'sp-select-next-thing)
(define-key smartparens-mode-map (kbd "s-}") 'sp-select-next-thing-exchange)

(define-key smartparens-mode-map (kbd "M-<backspace>") nil)
(define-key smartparens-mode-map (kbd "s-<backspace>") 'sp-backward-unwrap-sexp)

;;

(setq sp-highlight-pair-overlay nil)
;;(setq sp-hybrid-kill-excessive-whitespace 1)

(provide 'smartparens-module)
