;; lisp-module

(require 'package-module)

(use-package sly
  :mode ("\\.lisp\\'" . lisp-mode)
  :bind (:map lisp-mode-map
	 ("s-c" . sly-compile-and-load-file))

  :diminish (which-key-mode)

  :hook ((sly-mrepl . (lambda ()
			(define-key sly-mrepl-mode-map (kbd "C-c C-o") 'sly-mrepl-clear-repl))))
  :init
  (setf sly-lisp-implementations '((sbcl ("sbcl") :coding-system utf-8-unix)
				   (ccl ("ccl") :coding-system utf-8-unix)))
  (setf sly-default-lisp 'sbcl)

  (setf sly-complete-symbol-function #'sly-flex-completions)

  :config
  (yas-minor-mode-on)
  (bind-lisp-snippets lisp-mode-map)
  (advice-add 'sly-compile-and-load-file :before #'save-current-buffer-if-modified)

  (defmacro define-sly-lisp (name)
    `(defun ,name ()  (interactive)
	    (let ((sly-default-lisp ',name))
	      (sly))))

  (define-sly-lisp sbcl)
  (define-sly-lisp ccl))

(use-package company
  :init
  (add-hook 'lisp-mode-hook 'company-mode)
  (add-hook 'sly-mrepl-hook 'company-mode)
  :bind (:map lisp-mode-map
	      ("TAB" . company-indent-or-complete-common)))

(use-package sly-asdf
  :after sly)

(use-package sly-quicklisp
  :after sly

  :hook ((sly-quicklisp-mode . (lambda ()
				 (setq sly-extra-mode-line-constructs
				       '(sly-quicklisp--mode-line-construct--hack)))))
  :config

  (require 'seq)

  (defun sly-quicklisp--mode-line-construct--hack ()
    (let ((line (sly-quicklisp--mode-line-construct)))
      (seq-filter (lambda (x) (not (member x '(face hi-pink)))) line))))

(provide 'lisp-module)
