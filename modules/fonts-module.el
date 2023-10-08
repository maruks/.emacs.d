;; fonts-module

(require 'package-module)

(setq font (getenv "EMACS_DEFAULT_FONT"))

(when (eq system-type 'darwin)
  (setq font (or font "Menlo-15")))  ;; Source Code Pro-15

(when (eq system-type 'gnu/linux)
  (setq font (or font "DejaVu Sans Mono-10")))

(when font
  (set-frame-font font nil t)
  (add-to-list 'default-frame-alist (cons 'font font)))

(provide 'fonts-module)
