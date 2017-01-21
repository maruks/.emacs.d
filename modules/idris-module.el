;; idris-module

(require 'package-module)

(package-require 'idris-mode)

(defvar idris-font-lock-table (make-hash-table))

(puthash
 'leuven
 '((idris-equals-face ((t (:foreground "black"))))
   (idris-colon-face ((t (:foreground "black"))))
   (idris-hole-face ((t (:underline (:color "#006DAF" :style wave) :slant italic))))
   (idris-operator-face ((t (:foreground "black"))))
   (idris-repl-output-face ((t (:foreground "#606060"))))
   (idris-semantic-function-face ((t (:foreground "darkgreen"))))
   (idris-semantic-implicit-face ((t (:slant italic))))
   (idris-semantic-data-face ((t (:foreground "red3"))))
   (idris-keyword-face ((t (:foreground "black" :weight semi-bold))))
   (idris-directive-face ((t (:foreground "dim gray"))))
   (idris-inline-doc-face ((t (:foreground "dim gray"))))
   (idris-parameter-face ((t (:inherit idris-semantic-bound-face))))
   (idris-module-face ((t (:inherit idris-semantic-module-face))))
   (idris-info-title-face ((t (:height 1.8 :weight bold :foreground "cornflower blue" :family "PT Sans Narrow"))))
   (idris-quasiquotation-face ((t (:background "light gray"))))
   (idris-antiquotation-face ((t (:background "white" :box "light gray")))))
 idris-font-lock-table)

(defun idris-apply-font-locks (theme)
  (let ((faces (gethash theme idris-font-lock-table)))
    (when faces
      (apply 'custom-theme-set-faces theme faces))))

(eval-after-load 'idris-mode
  '(progn
     (define-key idris-mode-map [?\s-c] 'idris-load-file)
     (define-key idris-mode-map (kbd "<f5>") 'idris-load-file)))

(defun idris-theme-tracing-function (&rest args)
  (idris-apply-font-locks (car args))
  (message "display-buffer called with args %S" args))

(advice-add 'theme-enable :after #'idris-theme-tracing-function)

(provide 'idris-module)
