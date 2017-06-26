;; smartparens-module

(require 'package-module)

(package-require 'smartparens)

(require 'smartparens-config)

(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
(add-hook 'scheme-mode-hook #'smartparens-strict-mode)

(add-hook 'cider-repl-mode-hook #'smartparens-mode)
(add-hook 'slime-repl-mode-hook #'smartparens-mode)
(add-hook 'ielm-mode-hook #'smartparens-mode)
(add-hook 'lisp-interaction-mode-hook #'smartparens-mode)
(add-hook 'geiser-repl-mode-hook #'smartparens-mode)

(add-hook 'js-mode-hook #'smartparens-mode)
(add-hook 'elixir-mode-hook #'smartparens-mode)
(add-hook 'html-mode-hook #'smartparens-mode)
(add-hook 'lua-mode-hook #'smartparens-mode)
(add-hook 'ruby-mode-hook #'smartparens-mode)
(add-hook 'rust-mode-hook #'smartparens-mode)

;; keybindings

(sp-use-smartparens-bindings)

(define-key smartparens-mode-map (kbd "M-s") 'sp-splice-sexp)
(define-key smartparens-mode-map (kbd "M-j") 'sp-join-sexp)

(define-key smartparens-mode-map (kbd "M-D") 'sp-absorb-sexp)

(define-key smartparens-mode-map (kbd "s-[") 'sp-select-previous-thing)
(define-key smartparens-mode-map (kbd "s-{") 'sp-select-previous-thing-exchange)

(define-key smartparens-mode-map (kbd "s-]") 'sp-select-next-thing)
(define-key smartparens-mode-map (kbd "s-}") 'sp-select-next-thing-exchange)

;;
(setq sp-highlight-pair-overlay nil)

(provide 'smartparens-module)
