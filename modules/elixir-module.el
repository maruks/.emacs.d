;; elixir-module

(require 'package-module)

(use-package
 eglot
 :ensure nil
 :config (add-to-list 'eglot-server-programs '(elixir-ts-mode "/Users/maris/Projects/elixir-ls/_build/release/language_server.sh")))

(use-package
  elixir-ts-mode
  :hook ((elixir-ts-mode . eglot-ensure)
	 ;;	(elixir-ts-mode . heex-ts-mode)
	 (elixir-ts-mode . company-mode)
	 )

  :config

  (defun elixir/find-mix-project (dir)
    "Try to locate a Elixir project root by 'mix.exs' above DIR."
    (let ((mix_root (locate-dominating-file dir "mix.exs")))
      (message "Found Elixir project root in '%s' starting from '%s'" mix_root dir)
      (if (stringp mix_root) `(transient . ,mix_root) nil)))

  (add-hook 'project-find-functions 'elixir/find-mix-project nil nil)
  )

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
