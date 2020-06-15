;; haskell-module

(require 'package-module)

(package-require 'haskell-mode)
(package-require 'lsp-mode)
(package-require 'lsp-haskell)

(setq lsp-keymap-prefix "C-c l")

(setq lsp-haskell-process-path-hie "hie-wrapper")

(use-package lsp-mode
  :hook ((haskell-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :config
  (require 'lsp-haskell))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-flycheck-live-reporting nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-show-diagnostics nil))

(provide 'haskell-module)
