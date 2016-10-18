;; haskell-intero-module

(require 'package-module)

;; stack install stylish-haskell hlint hasktags ghc-mod hoogle hindent happy

(add-to-list 'exec-path "~/.local/bin/")

(package-require 'haskell-mode)
;(package-require 'hindent)
(package-require 'intero)

(custom-set-variables
 '(haskell-process-type 'stack-ghci))

(setq haskell-compile-cabal-build-command "stack build")

(defun compile-hs-buffer (arg)
  (interactive "P")
  (save-buffer)
  (haskell-compile))

(defun haskell-m0de-hook ()
  (interactive)
  ;(hindent-mode)
  ;(turn-on-haskell-indentation)
  (haskell-indentation-mode)
  (electric-indent-mode)
  (intero-mode))

(add-hook 'haskell-mode-hook 'haskell-m0de-hook)

(eval-after-load 'haskell-mode '(progn
				  (define-key haskell-mode-map (kbd "<f5>") 'compile-hs-buffer)
				  (define-key haskell-mode-map [?\s-c] 'compile-hs-buffer)
				  (define-key haskell-mode-map (kbd "C-c C-z") 'intero-repl-load)))

(provide 'haskell-intero-module)
