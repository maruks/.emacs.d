;; haskell-intero-module

(require 'package-module)

;; stack install stylish-haskell hlint hasktags ghc-mod hoogle hindent happy

;; stack install structured-haskell-mode
;; (lts-3.8)

(add-to-list 'exec-path "~/.local/bin/")

(package-require 'haskell-mode)
(package-require 'hindent)
;(package-require 'shm)
(package-require 'intero)

(custom-set-variables
 '(haskell-process-type 'stack-ghci))

(setq haskell-compile-cabal-build-command "stack build")

(defun build-stack-project (arg)
  (interactive "P")
  (save-buffer)
  (haskell-compile))

(defun haskell-m0de-hook ()
  (interactive)
  (intero-mode)
  ;(structured-haskell-mode)
  (hindent-mode)
  )

(add-hook 'haskell-mode-hook 'haskell-m0de-hook)

(eval-after-load 'haskell-mode '(progn
				  (define-key haskell-mode-map (kbd "<f5>") 'intero-repl-load)
				  (define-key haskell-mode-map [?\s-c] 'intero-repl-load)
				  (define-key haskell-mode-map (kbd "<f9>") 'build-stack-project)))

(with-eval-after-load 'intero
  (flycheck-add-next-checker 'intero
                             '(warning . haskell-hlint)))

(provide 'haskell-intero-module)
