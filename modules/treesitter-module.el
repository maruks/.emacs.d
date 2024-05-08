;; treesitter-module

(use-package
  emacs
  :ensure nil
  :config

  (setq treesit-language-source-alist
	'((heex "https://github.com/phoenixframework/tree-sitter-heex")
	  (elixir "https://github.com/elixir-lang/tree-sitter-elixir")))

  ;; Should use:
  ;; install-treesitter-grammars
  ;; at least once per installation or while changing this list
  (defun install-treesitter-grammars ()
    (interactive)
    (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist)))

  :custom
  (major-mode-remap-alist
   '((elixir-mode . elixir-ts-mode)))
  )

(provide 'treesitter-module)
