;; elm-module
;; https://github.com/jcollard/elm-mode
;; npm install --global elm elm-live elm-test elm-format@exp elm-oracle

(require 'package-module)

(package-require 'elm-mode)
(package-require 'company)

(add-hook 'elm-mode-hook #'company-mode)

(with-eval-after-load "company"
  (add-to-list 'company-backends 'company-elm))

(provide 'elm-module)
