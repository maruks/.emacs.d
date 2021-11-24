;; json-module

(require 'package-module)

(use-package json-mode
  :mode ("\\.json\\'" . json-mode)

  :config
  (use-package json-reformat)
  (use-package json-snatcher)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (setq-default json-reformat:indent-width 2))

(use-package flycheck-mode
  :hook json-mode
  :ensure flycheck)

(provide 'json-module)
