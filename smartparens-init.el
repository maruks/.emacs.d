(require 'smartparens-config)
(smartparens-mode t)
(show-smartparens-mode t)

;; disable highlightning

(setq sp-highlight-pair-overlay nil)
(setq sp-highlight-wrap-overlay nil)
(setq sp-highlight-wrap-tag-overlay nil)

;; navigation

(define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)

(define-key sp-keymap (kbd "C-M-n") 'sp-next-sexp)
(define-key sp-keymap (kbd "C-M-p") 'sp-previous-sexp)

(define-key sp-keymap (kbd "C-M-d") 'sp-down-sexp)
(define-key sp-keymap (kbd "C-M-a") 'sp-backward-down-sexp)
(define-key sp-keymap (kbd "C-S-a") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "C-S-d") 'sp-end-of-sexp)

(define-key sp-keymap (kbd "C-M-e") 'sp-up-sexp)
(define-key sp-keymap (kbd "C-M-u") 'sp-backward-up-sexp)

(define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)

;; manipulation

(define-key sp-keymap (kbd "C-k") 'sp-kill-sexp)

(define-key sp-keymap [delete] 'sp-delete-char)
(define-key sp-keymap [backspace] 'sp-backward-delete-char)

(define-key sp-keymap (kbd "C-M-w") 'sp-copy-sexp)

(define-key sp-keymap (kbd "C-M-}") 'sp-unwrap-sexp)
(define-key sp-keymap (kbd "C-M-{") 'sp-backward-unwrap-sexp)

(define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "C-M-<right>") 'sp-backward-barf-sexp)

(define-key sp-keymap (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
(define-key sp-keymap (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(define-key sp-keymap (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(define-key sp-keymap (kbd "C-]") 'sp-select-next-thing)
(define-key sp-keymap (kbd "C-M-]") 'sp-select-previous-thing)
(define-key sp-keymap (kbd "C-#") 'sp-select-next-thing-exchange)

(define-key sp-keymap (kbd "M-F") 'sp-forward-symbol)
(define-key sp-keymap (kbd "M-B") 'sp-backward-symbol)

(define-key sp-keymap (kbd "M-s") 'sp-splice-sexp)
(define-key sp-keymap (kbd "M-S") 'sp-split-sexp)
(define-key sp-keymap (kbd "M-J") 'sp-join-sexp)

(define-key sp-keymap (kbd "C-M-T") 'sp-transpose-sexp)

;;(define-key sp-keymap (kbd "") 'sp-convolute-sexp)
;;(define-key sp-keymap (kbd "") 'sp-absorb-sexp) 
;;(define-key sp-keymap (kbd "") 'sp-emit-sexp) 
;;(define-key sp-keymap (kbd "") 'sp-extract-before-sexp)
;;(define-key sp-keymap (kbd "") 'sp-extract-after-sexp) 
;;(define-key sp-keymap (kbd "") 'sp-rewrap-sexp)
;;(define-key sp-keymap (kbd "") 'sp-swap-enclosing-sexp)
;;(define-key sp-keymap (kbd "") 'sp-add-to-next-sexp) 
;;(define-key sp-keymap (kbd "") 'sp-add-to-previous-sexp)

;; pair management

(sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)

;; html-mode
(sp-with-modes '(html-mode sgml-mode)
  (sp-local-pair "<" ">"))

;; lisp modes
(sp-with-modes sp--lisp-modes
  (sp-local-pair "(" nil :bind "C-("))
