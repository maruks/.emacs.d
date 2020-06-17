;; elixir-module

(require 'package-module)

(use-package elixir-mode)

(use-package alchemist-mode
  :ensure alchemist
  :hook elixir-mode
  :bind (:map elixir-mode-map
	      ("s-c" . alchemist-iex-compile-this-buffer)
	      ("C-c C-l" . alchemist-iex-project-run)
	      ("C-c a i t" . alchemist-iex-reload))
  :init
  (defun alchemist-iex-reload (&optional arg)
    (interactive "P")
    (when (buffer-live-p alchemist-iex-buffer)
      (kill-process (get-buffer-process alchemist-iex-buffer))
      (sleep-for 1)
      (if arg
  	  (call-interactively 'alchemist-iex-project-run)
        (call-interactively 'alchemist-iex-run))))
  :config
  (advice-add 'alchemist-iex-compile-this-buffer :before #'save-current-buffer-if-modified))

(use-package company
  :init
  (add-hook 'elixir-mode-hook 'company-mode)
  :bind (:map elixir-mode-map
	      ("TAB" . company-indent-or-complete-common)))

(use-package flycheck-mode
  :hook elixir-mode
  :ensure flycheck
  :config
  (use-package flycheck-credo)
  (flycheck-credo-setup))

(provide 'elixir-module)
