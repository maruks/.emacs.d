;; rust-module

(require 'package-module)

(package-require 'company)
(package-require 'rustic)
(package-require 'cargo)
(package-require 'flycheck)
(package-require 'flycheck-rust)
(package-require 'racer)
(package-require 'rust-playground)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook 'flycheck-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)

(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(add-to-list 'exec-path "/Users/maris/.cargo/bin")

; rustup component add rust-src

(provide 'rust-module)
