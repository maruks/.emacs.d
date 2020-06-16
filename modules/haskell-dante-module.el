;; haskell-dante-module

(require 'package-module)

;; stack install stylish-haskell hlint hasktags ghc-mod hoogle hindent happy

;; (add-to-list 'exec-path "~/.local/bin/")

(package-require 'haskell-mode)
(package-require 'dante)
;; (package-require 'ghc)
;; (package-require 'company-ghc)
(package-require 'flycheck-haskell)

(use-package dante-mode
  :hook haskell-mode
  :bind (("C-c C-z" . haskell-interactive-bring)
	 ("C-c b" . haskell-process-cabal-build)
	 ("s-c" . haskell-process-load-file))
  :commands 'dante-mode
  :config
  (setq dante-methods '(stack))
  (advice-add 'haskell-process-load-file :before #'save-current-buffer-if-modified))

(use-package flycheck-mode
  :after dante
  :hook dante-mode
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-add-next-checker 'haskell-dante
			     '(warning . haskell-hlint)))

(provide 'haskell-dante-module)
