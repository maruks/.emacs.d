;; elm-module

(require 'package-module)

(package-require 'elm-mode)

(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)

;; https://github.com/jcollard/elm-mode

(provide 'elm-module)
