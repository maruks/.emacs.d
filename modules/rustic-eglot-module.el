;; rustic-eglot-module

(require 'package-module)

(use-package rustic
  :bind (:map rustic-mode-map
	      ("s-c" . rustic-recompile)
	      ("C-c C-c l" . flycheck-list-errors)
	      ("C-c C-c h" . eldoc-doc-buffer)
	      ("C-c C-c a" . eglot-code-actions)
	      ("C-c C-c t" . rustic-cargo-current-test)
	      ("C-c C-c r" . eglot-rename)
	      ("C-c C-c i" . xref-find-references))
  :hook ((eglot--managed-mode . company-mode)
	 (eglot--managed-mode . flycheck-rust-setup)
	 (eglot--managed-mode . (lambda () (flymake-mode -1)))
	 (eglot--managed-mode . (lambda () (yas-minor-mode-on))))
  :custom
  (rustic-lsp-client 'eglot)
  :config
  (use-package flycheck-rust)
  (add-to-list 'flycheck-checkers 'rustic-clippy)
  (bind-rust-snippets rustic-mode-map)
  (advice-add 'rustic-recompile :before #'save-current-buffer-if-modified)
  (advice-add 'rustic-cargo-current-test :before #'save-current-buffer-if-modified)
  (advice-add 'rustic-cargo-test :before #'save-current-buffer-if-modified))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(rustic-mode . ("rust-analyzer"))))

(use-package company
  :bind (:map company-mode-map
	      ("<tab>". tab-indent-or-complete)
	      ("TAB". tab-indent-or-complete))
  :custom
  (company-idle-delay 0.5))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(provide 'rustic-eglot-module)
