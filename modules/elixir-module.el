;; elixir-module

(require 'package-module)

(package-require 'alchemist)
(package-require 'flycheck-credo)
(package-require 'flycheck-mix)

(add-hook 'elixir-mode-hook
	  (lambda ()
	    (flycheck-mode)
	    (alchemist-mode)
	    (company-mode)
   	    (define-key elixir-mode-map (kbd "<f5>") 'alchemist-iex-compile-this-buffer)
	    (define-key elixir-mode-map [?\s-c]      'alchemist-iex-compile-this-buffer)
	    (advice-add 'alchemist-iex-compile-this-buffer :before #'save-current-buffer-if-modified)))

(eval-after-load 'flycheck
  (lambda ()
    (flycheck-credo-setup)
    (flycheck-mix-setup)))

(provide 'elixir-module)
