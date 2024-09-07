;; gleam-module

(require 'package-module)

(use-package
 eglot
 :ensure nil
 :config (add-to-list 'eglot-server-programs '(gleam-ts-mode . ("gleam" "lsp"))))

;; M-x gleam-ts-install-grammar

(use-package gleam-ts-mode
  :mode (rx ".gleam" eos)
  :hook ((elixir-ts-mode . eglot-ensure)))

(provide 'gleam-module)
