;; lisp-module

(require 'package-module)

(package-require 'sly)

;; (setq inferior-lisp-program "sbcl")

(setf sly-lisp-implementations '((sbcl ("sbcl" "--dynamic-space-size" "1024"))
				 (roswell ("ros" "-Q" "run"))))

(setf sly-default-lisp 'roswell)

(eval-after-load 'lisp-mode
  '(progn
     (define-key lisp-mode-map [?\s-c] 'sly-compile-and-load-file)
     (advice-add 'sly-compile-and-load-file :before #'save-current-buffer-if-modified)))

(provide 'lisp-module)
