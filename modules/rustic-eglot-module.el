;; rustic-eglot-module

(require 'package-module)

(use-package rustic
  :bind (:map rustic-mode-map
	      ("s-c" . rustic-recompile)
	      ("C-c C-c l" . flycheck-list-errors))
  :hook ((eglot--managed-mode . company-mode)
	 (eglot--managed-mode . (lambda () (flymake-mode -1))))
  :custom
  (rustic-lsp-client 'eglot)
  :config
  (advice-add 'rustic-recompile :before #'save-current-buffer-if-modified)
  (advice-add 'rustic-cargo-current-test :before #'save-current-buffer-if-modified)
  (advice-add 'rustic-cargo-test :before #'save-current-buffer-if-modified))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(rustic-mode . ("rust-analyzer"))))

(provide 'rustic-eglot-module)
