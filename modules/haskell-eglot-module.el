;; haskell-eglot-module

(require 'package-module)

;; stack install stylish-haskell hlint hasktags ghc-mod hoogle hindent happy

;; (add-to-list 'exec-path "~/.local/bin/")

(package-require 'haskell-mode)
(package-require 'eglot)

(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

;; (use-package eglot
;;   :hook haskell-mode
;; ;;  :commands 'eglot-mode
;;   )


(provide 'haskell-eglot-module)
