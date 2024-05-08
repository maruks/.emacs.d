;; elixir-module

(require 'package-module)

(use-package
 eglot
 :ensure nil
 :config (add-to-list 'eglot-server-programs '(elixir-ts-mode "start_lexical.sh")))

(use-package
 elixir-ts-mode
 :hook ((elixir-ts-mode . eglot-ensure)
;;	(elixir-ts-mode . heex-ts-mode)
	(elixir-ts-mode . company-mode)
	))

(use-package inf-elixir
  :after (elixir-ts-mode)
  :bind (:map elixir-ts-mode-map
	 ("C-c i i" . 'inf-elixir)
         ("C-c i p" . 'inf-elixir-project)
         ("C-c i l" . 'inf-elixir-send-line)
         ("C-c i r" . 'inf-elixir-send-region)
         ("C-c i b" . 'inf-elixir-send-buffer)
         ("C-c i R" . 'inf-elixir-reload-module)))

(use-package mix
  :config
  (add-hook 'elixir-ts-mode-hook 'mix-minor-mode))

(provide 'elixir-module)
