;; ebooks-module

(require 'package-module)

(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(provide 'ebooks-module)
