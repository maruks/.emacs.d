;; elixir-module

(require 'package-module)

(use-package
 eglot
 :ensure nil
 :config (add-to-list 'eglot-server-programs '(elixir-ts-mode "~/bin/elixir-ls/language_server.sh")))

(use-package
  elixir-ts-mode
  :hook ((elixir-ts-mode . eglot-ensure)
;;  	(elixir-ts-mode . heex-ts-mode)
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
         ("C-c i R" . 'inf-elixir-reload-module)
         ("s-c" . 'inf-elixir-reload-module))
  :config
  (advice-add 'inf-elixir-reload-module :before #'save-current-buffer-if-modified)
  (advice-add 'inf-elixir-send-buffer :before #'save-current-buffer-if-modified)

  (bind-elixir-snippets elixir-ts-mode-map)

  )

;; C-c d t - mix-test
;; C-c d o - mix-test-current-buffer
;; C-c d f - mix-test-current-test
(use-package mix
  :config
  (add-hook 'elixir-ts-mode-hook 'mix-minor-mode))

(provide 'elixir-module)
