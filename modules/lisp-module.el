;; lisp-module

(require 'package-module)

(package-require 'company)
(package-require 'sly)
(package-require 'sly-quicklisp)

;; (package-require 'sly-asdf)
;; (require 'sly-asdf)

(setf sly-lisp-implementations '((sbcl ("sbcl") :coding-system utf-8-unix)
				 (ccl ("ccl") :coding-system utf-8-unix)))

(setf sly-default-lisp 'sbcl)

(add-hook 'lisp-mode-hook #'company-mode)
(add-hook 'sly-mrepl-hook #'company-mode)

(eval-after-load 'lisp-mode
  '(progn
     (define-key lisp-mode-map (kbd "TAB") #'company-indent-or-complete-common)
     (define-key lisp-mode-map [?\s-c] 'sly-compile-and-load-file)
     (advice-add 'sly-compile-and-load-file :before #'save-current-buffer-if-modified)))

(eval-after-load 'sly-mrepl
  '(define-key sly-mrepl-mode-map (kbd "C-c C-o") 'sly-mrepl-clear-recent-output))

(defmacro define-sly-lisp (name)
  `(defun ,name ()  (interactive)
	  (let ((sly-default-lisp ',name))
	    (sly))))

(define-sly-lisp sbcl)
(define-sly-lisp ccl)

(provide 'lisp-module)
