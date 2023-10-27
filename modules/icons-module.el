;; icons-module

(require 'package-module)

;; M-x all-the-icons-install-fonts

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

(provide 'icons-module)
