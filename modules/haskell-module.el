;; haskell-module

(require 'package-module)

;; cabal update
;; cabal install happy hasktags stylish-haskell present ghc-mod hlint hoogle structured-haskell-mode hindent

(package-require 'haskell-mode)
(package-require 'ghc)

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)


;; haskell
;;(add-to-list 'load-path "~/.emacs.d/vendor/haskell-ac")
;;(require 'haskell-ac)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(custom-set-variables
  '(haskell-process-type 'cabal-repl)
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t)
  '(haskell-tags-on-save t))

(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map [f9] 'haskell-navigate-imports)
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile)
  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))

(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(add-to-list 'completion-ignored-extensions ".hi")

;; https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md

(provide 'haskell-module)
