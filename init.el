

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/modules")

(require 'package-module)

;; modules

(require 'appearance-module)
(require 'mituharu-module)
(require 'fonts-module)
(require 'global-module)
(require 'fundamental-module)
(require 'git-module)
(require 'fullframe-module)
(require 'smartparens-module)
;;(require 'paredit-module)

(require 'electric-pair-module)
(require 'smart-mode-line-module)
(require 'scheme-module)
(require 'erlang-module)
(require 'elixir-module)
(require 'clojure-module)
(require 'sml-module)

(require 'idris-module)
(require 'ocaml-module)
(require 'rust-module)
(require 'scala-module)

(require 'haskell-intero-module)
;;(require 'haskell-module)

(require 'elm-module)
(require 'elisp-module)
(require 'lisp-module)
;; (require 'lisp-slime-module)
(require 'lua-module)
(require 'javascript-module)
(require 'xml-module)
(require 'snippets-module)
(require 'themes-module)
(require 'flycheck-module)
(require 'hydra-module)
(require 'user-module)
