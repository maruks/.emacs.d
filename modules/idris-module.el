;; idris-module

(require 'package-module)

(package-require 'idris-mode)

(defvar idris-font-lock-table (make-hash-table))

(puthash
 'tomorrow-night-eighties
 '((idris-keyword-face ((t (:inherit font-lock-keyword-face))))
   (idris-identifier-face ((t (:foreground "#f2777a"))))
   (idris-equals-face ((t (:foreground "#cccccc"))))
   (idris-colon-face ((t (:foreground "#cccccc"))))
   (idris-hole-face ((t (:underline (:color "#f2777a" :style wave)))))
   (idris-operator-face ((t (:foreground "#cc99cc"))))
   (idris-repl-output-face ((t (:foreground "#cccccc"))))
   (idris-directive-face ((t (:foreground "#cccccc"))))
   (idris-inline-doc-face ((t (:foreground "#999999"))))
   (idris-info-title-face ((t (:height 1.8 :weight bold :foreground "#66cccc" :family "PT Sans Narrow"))))
   (idris-quasiquotation-face ((t (:background "#2d2d2d"))))
   (idris-antiquotation-face ((t (:background "#2d2d2d" :box "#cccccc"))))
   (idris-semantic-implicit-face ((t (:slant italic))))
   (idris-semantic-data-face ((t (:foreground "#f99157"))))
   (idris-semantic-function-face ((t (:foreground "#cccccc"))))
   (idris-semantic-module-face ((t (:foreground "#ffcc66"))))
   (idris-semantic-type-face ((t (:foreground "#6699cc" ))))
   (idris-semantic-bound-face ((t (:foreground "#cccccc"))))
   (idris-parameter-face ((t (:inherit idris-semantic-bound-face))))
   (idris-module-face ((t (:inherit idris-semantic-module-face)))))
 idris-font-lock-table)

(puthash
 'atom-one-dark
 '((idris-keyword-face ((t (:inherit font-lock-keyword-face))))
   (idris-identifier-face ((t (:foreground "#E06C75"))))
   (idris-equals-face ((t (:foreground "#ABB2BF"))))
   (idris-colon-face ((t (:foreground "#ABB2BF"))))
   (idris-hole-face ((t (:underline (:color "#E06C75" :style wave)))))
   (idris-operator-face ((t (:foreground "#C678DD"))))
   (idris-repl-output-face ((t (:foreground "#ABB2BF"))))
   (idris-directive-face ((t (:foreground "#ABB2BF"))))
   (idris-inline-doc-face ((t (:foreground "#828997"))))
   (idris-info-title-face ((t (:height 1.8 :weight bold :foreground "#528BFF" :family "PT Sans Narrow"))))
   (idris-quasiquotation-face ((t (:background "#2F343D"))))
   (idris-antiquotation-face ((t (:background "#2F343D" :box "#ABB2BF"))))
   (idris-semantic-implicit-face ((t (:slant italic))))
   (idris-semantic-data-face ((t (:foreground "#D19A66"))))
   (idris-semantic-function-face ((t (:foreground "#ABB2BF"))))
   (idris-semantic-module-face ((t (:foreground "#E5C07B"))))
   (idris-semantic-type-face ((t (:foreground "#61AFEF" ))))
   (idris-semantic-bound-face ((t (:foreground "#ABB2BF"))))
   (idris-parameter-face ((t (:inherit idris-semantic-bound-face))))
   (idris-module-face ((t (:inherit idris-semantic-module-face)))))
 idris-font-lock-table)

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

(puthash
 'flatland
 '((idris-semantic-type-face ((t (:inherit font-lock-type-face))))
   (idris-keyword-face ((t (:inherit font-lock-keyword-face))))
   (idris-semantic-bound-face ((t (:inherit font-lock-variable-name-face))))
   (idris-semantic-function-face ((t (:foreground "#f8f8f8"))))
   (idris-identifier-face ((t (:foreground "#93e0e3"))))
   (idris-equals-face ((t (:foreground "#e0e0e0"))))
   (idris-colon-face ((t (:foreground "#e0e0e0" ))))
   (idris-hole-face ((t (:underline (:color "#ff3a83" :style wave) :slant italic))))
   (idris-operator-face ((t (:foreground "#dc8cc3"))))
   (idris-repl-output-face ((t (:foreground "#afc4db"))))
   (idris-semantic-implicit-face ((t (:slant italic))))
   (idris-semantic-data-face ((t (:foreground "#cfe2f2"))))
   (idris-directive-face ((t (:foreground "#b1b3ba"))))
   (idris-inline-doc-face ((t (:foreground "#b1b3ba"))))
   (idris-info-title-face ((t (:height 1.8 :weight bold :foreground "#72aaca" :family "PT Sans Narrow"))))
   (idris-quasiquotation-face ((t (:background "#b0b3ba"))))
   (idris-antiquotation-face ((t (:background "#73817d" :box "#b0b3ba"))))
   (idris-parameter-face ((t (:inherit idris-semantic-bound-face))))
   (idris-module-face ((t (:inherit idris-semantic-module-face)))))
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
  (idris-apply-font-locks (car args)))

(advice-add 'theme-enable :after #'idris-theme-tracing-function)

(provide 'idris-module)
