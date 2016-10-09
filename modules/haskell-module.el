;; haskell-module

(require 'package-module)

;; stack install stylish-haskell hlint hasktags ghc-mod hoogle hindent happy

(add-to-list 'exec-path "~/.local/bin/")

(package-require 'haskell-mode)
(package-require 'hindent)
(package-require 'ghc)
(package-require 'company-ghc)
(package-require 'flycheck-haskell)

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

(defun haskell-m0de-hook ()
  (interactive)
  (turn-on-haskell-doc-mode)
  (hindent-mode)
  (turn-on-haskell-indentation)
  (ghc-init)
  (company-mode)
  (flycheck-mode))

(add-hook 'haskell-mode-hook 'haskell-m0de-hook)

(require 'company-ghc)
(add-to-list 'company-backends 'company-ghc)

(custom-set-variables
 '(company-ghc-show-info t)
 '(haskell-process-type 'stack-ghci)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-tags-on-save t))

(setq haskell-compile-cabal-build-command "stack build")

(defun compile-hs-buffer (arg)
  (interactive "P")
  (save-buffer)
  (haskell-compile))

;; (require 'haskell-interactive-mode)
;; (require 'haskell-process)
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(eval-after-load 'haskell-mode '(progn
				  (define-key haskell-mode-map (kbd "<f9>") 'haskell-navigate-imports)
				  (define-key haskell-mode-map (kbd "<f5>") 'compile-hs-buffer)
				  (define-key haskell-mode-map [?\s-c] 'compile-hs-buffer)
				  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
				  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-bring)
				  (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
				  (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
				  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
				  (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
				  (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
				  (define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile)))

(eval-after-load 'haskell-cabal '(progn
				   (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
				   (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
				   (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
				   (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(add-to-list 'completion-ignored-extensions ".hi")

;; https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md

(provide 'haskell-module)
