;; rust-module

(require 'package-module)

(use-package rust-mode
  :mode ("\\.rust$" . rust-mode)
  :commands (rust-mode))

(use-package cargo
  :after rust-mode
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package racer
  :after rust-mode
  :diminish racer-mode
  :bind (:map rust-mode-map
              ("C-c C-t" . racer-describe)
	      ("s-c" . rust-compile))
  :init
  (add-hook 'rust-mode-hook 'racer-mode)
  :config
  (add-hook 'racer-mode-hook 'eldoc-mode)
  (advice-add 'rust-compile :before #'save-current-buffer-if-modified))

(use-package rust-playground
  :commands (rust-playground))

(use-package flycheck
  :after rust-mode)

(use-package flycheck-rust
  :after (rust-mode flycheck)
  :init
  (add-hook 'rust-mode-hook 'flycheck-mode)
  (add-hook 'flycheck-mode-hook 'flycheck-rust-setup))

(use-package company
  :after rust-mode
  :init
  (add-hook 'rust-mode-hook 'company-mode)
  :bind (:map rust-mode-map
	      ("TAB" . company-indent-or-complete-common))
  :config
  (setq company-tooltip-align-annotations t))

; rustup component add rust-src

(provide 'rust-module)
