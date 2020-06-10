;; yaml-module

(package-require 'yaml-mode)
(package-require 'indent-tools)

(use-package yaml
  :mode (("\\.yml\\'"  . yaml-mode)
         ("\\.yaml\\'" . yaml-mode))
  :bind
  (("\C-m" . #'newline-and-indent)))

(use-package indent-tools
  :bind
  (("C-c i" . #'indent-tools-hydra/body))  )

;; npm install -g js-yaml
(use-package flycheck
  :init
  (add-hook 'yaml-mode-hook 'flycheck-mode))

(provide 'yaml-module)
