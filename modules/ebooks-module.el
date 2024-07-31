;; ebooks-module

(require 'package-module)

(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :custom
  (nov-text-width 80))

(provide 'ebooks-module)
