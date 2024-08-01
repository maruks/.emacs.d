;; view-module

(require 'package-module)

(use-package view
  :ensure nil
  :bind (("s-9" . view-mode)))

(setq-default cursor-type 'bar)

(add-hook 'view-mode-hook (lambda ()
			    (setq cursor-type (if view-mode 'bar 'box ))
			    (hl-line-mode (if view-mode 1 -1))

			    (cond ((derived-mode-p 'org-mode)
				   (define-key view-mode-map (kbd "p") 'org-previous-visible-heading)
				   (define-key view-mode-map (kbd "n") 'org-next-visible-heading))
				  ((derived-mode-p 'markdown-mode)
				   (define-key view-mode-map (kbd "p") 'markdown-outline-previous)
				   (define-key view-mode-map (kbd "n") 'markdown-outline-next))
				  ((derived-mode-p 'html-mode)
				   (define-key view-mode-map (kbd "p") 'sgml-skip-tag-backward)
				   (define-key view-mode-map (kbd "n") 'sgml-skip-tag-forward))
				  ((derived-mode-p 'python-mode)
				   (define-key view-mode-map (kbd "p") 'python-nav-backward-block)
				   (define-key view-mode-map (kbd "n") 'python-nav-forward-block))
				  ((derived-mode-p 'emacs-lisp-mode)
				   (define-key view-mode-map (kbd "p") 'backward-sexp)
				   (define-key view-mode-map (kbd "n") 'forward-sexp))
				  ((derived-mode-p 'clojure-mode)
				   (define-key view-mode-map (kbd "p") 'backward-sexp)
				   (define-key view-mode-map (kbd "n") 'forward-sexp))
				  ((derived-mode-p 'lisp-mode)
				   (define-key view-mode-map (kbd "p") 'backward-sexp)
				   (define-key view-mode-map (kbd "n") 'forward-sexp))
				  ((derived-mode-p 'makefile-mode)
				   (define-key view-mode-map (kbd "p") 'makefile-previous-dependency)
				   (define-key view-mode-map (kbd "n") 'makefile-next-dependency))
				  ((derived-mode-p 'c-mode)
				   (define-key view-mode-map (kbd "p") 'c-beginning-of-defun)
				   (define-key view-mode-map (kbd "n") 'c-end-of-defun))
				  (t
				   (define-key view-mode-map (kbd "p") 'scroll-down-command)
				   (define-key view-mode-map (kbd "n") 'scroll-up-command)))

			    ))

(provide 'view-module)
