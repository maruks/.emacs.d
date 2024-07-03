;; macos-module

(require 'package-module)

(when (and (eq system-type 'darwin) (display-graphic-p))
  (select-frame-set-input-focus (selected-frame)))

(provide 'macos-module)
