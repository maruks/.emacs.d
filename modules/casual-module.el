;; casual-module

(require 'package-module)

;; M-x re-builder
(use-package re-builder
  :defer t)

(use-package casual-re-builder
  :ensure t
  :bind (:map
         reb-mode-map ("C-o" . casual-re-builder-tmenu)
         :map
         reb-lisp-mode-map ("C-o" . casual-re-builder-tmenu))
  :after (re-builder))

(provide 'casual-module)
