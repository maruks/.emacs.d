;; elm-module
;; https://github.com/jcollard/elm-mode
;; npm install --global elm elm-live elm-test elm-format@exp elm-oracle

(require 'package-module)

(package-require 'elm-mode)
(package-require 'flycheck-elm)
(package-require 'company)

(add-hook 'elm-mode-hook 'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-elm-setup)

(add-hook 'elm-mode-hook #'company-mode)

(with-eval-after-load "company"
  (add-to-list 'company-backends 'company-elm))


(defun save-buffer-if-modified (&rest args)
  (when (and buffer-file-name (buffer-modified-p)) (save-buffer)))

(eval-after-load 'elm-mode
  '(progn
     (define-key elm-mode-map [?\s-c] 'elm-compile-buffer)
     (define-key elm-mode-map (kbd "<f5>") 'elm-compile-buffer)
     (advice-add 'elm-compile-buffer :before  #'save-buffer-if-modified)))

(provide 'elm-module)
