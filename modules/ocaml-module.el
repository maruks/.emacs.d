;; ocaml-module

(require 'package-module)

;; opam install utop ocaml-lsp-server ocamlformat dune

;; Major mode for OCaml programming
(use-package tuareg
  :mode (("\\.ocamlinit\\'" . tuareg-mode))
  :hook (tuareg-mode . eglot-ensure)
  )

(add-to-list 'exec-path "~/.opam/default/bin")

;; Major mode for editing Dune project files
(use-package dune)

(use-package ocamlformat)

;; utop configuration
(use-package utop
  :config
  (add-hook 'tuareg-mode-hook #'utop-minor-mode))

(provide 'ocaml-module)
