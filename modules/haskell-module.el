;; haskell-module

(require 'package-module)

(package-require 'haskell-mode)

;; haskell
(add-to-list 'load-path "~/.emacs.d/vendor/haskell-ac")
(require 'haskell-ac)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(add-to-list 'completion-ignored-extensions ".hi")


(provide 'haskell-module)
