;; lisp-module

(require 'package-module)

(package-require 'sly)
(package-require 'sly-quicklisp)

(setf sly-lisp-implementations '((sbcl ("sbcl") :coding-system utf-8-unix)
				 (ccl ("ccl") :coding-system utf-8-unix)))

(setf sly-default-lisp 'sbcl)

(eval-after-load 'lisp-mode
  '(progn
     (define-key lisp-mode-map [?\s-c] 'sly-compile-and-load-file)
     (advice-add 'sly-compile-and-load-file :before #'save-current-buffer-if-modified)))

(defmacro define-sly-lisp (name)
  `(defun ,name ()  (interactive)
	  (let ((sly-default-lisp ',name))
	    (sly))))

(define-sly-lisp sbcl)
(define-sly-lisp ccl)

(provide 'lisp-module)
