;; lisp-module

(require 'package-module)

(package-require 'company)
(package-require 'sly)
(package-require 'sly-quicklisp)
(package-require 'sly-asdf)

(use-package sly
  :mode ("\\.lisp\\'" . lisp-mode)
  :bind (:map lisp-mode-map
	 ("TAB" . company-indent-or-complete-common)
	 ("s-c" . sly-compile-and-load-file))

  :diminish (company-mode which-key-mode)

  :hook ((lisp-mode . company-mode)
	 (sly-mrepl . company-mode)
	 (sly-mrepl . (lambda ()
			(define-key sly-mrepl-mode-map (kbd "C-c C-o") 'sly-mrepl-clear-repl))))
  :init
  (setf sly-lisp-implementations '((sbcl ("sbcl") :coding-system utf-8-unix)
				   (ccl ("ccl") :coding-system utf-8-unix)))
  (setf sly-default-lisp 'sbcl)

  (setf sly-complete-symbol-function #'sly-flex-completions)

  :config
  (advice-add 'sly-compile-and-load-file :before #'save-current-buffer-if-modified)

  (defmacro define-sly-lisp (name)
    `(defun ,name ()  (interactive)
	    (let ((sly-default-lisp ',name))
	      (sly))))

  (define-sly-lisp sbcl)
  (define-sly-lisp ccl))

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
