;; haskell-dante-module

(require 'package-module)

(package-require 'haskell-mode)

(use-package dante-mode
  :ensure dante
  :hook haskell-mode
  :bind (("C-c C-z" . haskell-interactive-bring)
	 ("C-c b" . haskell-process-cabal-build)
	 ("s-c" . haskell-process-load-file))
  :commands 'dante-mode
  :config
  (setq dante-methods '(stack))
  (advice-add 'haskell-process-load-file :before #'save-current-buffer-if-modified))

(use-package flycheck-mode
  :ensure flycheck-haskell
  :after dante
  :hook dante-mode
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-add-next-checker 'haskell-dante
			     '(warning . haskell-hlint)))

(provide 'haskell-dante-module)
