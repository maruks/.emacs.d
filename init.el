

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(add-to-list 'load-path "~/.emacs.d/modules")

(require 'package-module)

;; modules

(require 'use-package-module)

;; benchmark startup time
(use-package benchmark-init
  :ensure t
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; (require 'hydra-module)

(require 'appearance-module)
(require 'view-module)
;; (require 'mituharu-module)
(require 'fonts-module)
;; (require 'icons-module)
;; (require 'ivy-module)
(require 'global-module)
(require 'treesitter-module)
(require 'projectile-module)
;;(require 'ace-jump-module)
(require 'git-module)
(require 'ebooks-module)
(require 'fullframe-module)

(require 'snippets-module)

(require 'smartparens-module)
;;(require 'paredit-module)

(require 'electric-pair-module)
(require 'smart-mode-line-module)
(require 'scheme-module)
;; (require 'gerbil-module)
(require 'erlang-module)

(require 'elixir-module)
(require 'gleam-module)

(require 'clojure-module)

(require 'org-module)
(require 'json-module)
;; (require 'yaml-module)

;; (require 'idris-module)
;; (require 'ocaml-module)
;; (require 'rustic-eglot-module)
;; (require 'scala-module)
;; (require 'purescript-module)

;;(require 'haskell-intero-module)
;; (require 'haskell-lsp-module)

;;(require 'elm-module)
;;(require 'elisp-module)
(require 'lisp-module)
;; (require 'lisp-slime-module)
;;(require 'lua-module)
;; (require 'javascript-module)
;;(require 'xml-module)

(require 'vertico-module)
(require 'consult-module)
(require 'notes-module)
(require 'perspective-module)

(require 'themes-module)
(require 'user-module)

(require 'macos-module)
