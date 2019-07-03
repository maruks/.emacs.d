;; fullframe-module

(require 'package-module)

(package-require 'fullframe)

(eval-after-load 'magit
  (fullframe magit-status magit-mode-quit-window))

(eval-after-load 'ibuffer
  (fullframe ibuffer ibuffer-quit))

(provide 'fullframe-module)
