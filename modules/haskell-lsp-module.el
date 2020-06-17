;; haskell-lsp-module

(use-package haskell-mode)

(use-package lsp-haskell
  :config
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-haskell-process-path-hie "hie-wrapper"))

(use-package lsp-mode
  :hook ((haskell-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :bind (:map haskell-mode-map
	      ("<f5>" . haskell-compile)
	      ("s-c" . haskell-process-load-file))
  :init
  (custom-set-variables
   '(haskell-process-type 'stack-ghci)
   '(haskell-process-auto-import-loaded-modules t)
   '(haskell-process-log t))
  (setq haskell-compile-cabal-build-command "stack build")
  :config
  (use-package lsp-haskell)
  (advice-add 'haskell-compile :before #'save-current-buffer-if-modified)
  (advice-add 'haskell-process-load-file :before #'save-current-buffer-if-modified))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-flycheck-live-reporting nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-show-diagnostics nil))

(use-package company-lsp
  :config
  (push 'company-lsp company-backends))

(use-package company
  :init
  (add-hook 'haskell-mode-hook 'company-mode)
  :bind (:map haskell-mode-map
	      ("TAB" . company-indent-or-complete-common)))

(provide 'haskell-lsp-module)
