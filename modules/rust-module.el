;; rust-module

(require 'package-module)

(package-require 'cargo)
(package-require 'flycheck-rust)
(package-require 'rust-mode)
(package-require 'racer)
(package-require 'rust-playground)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)

(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

; rustup component add rust-src

(provide 'rust-module)
