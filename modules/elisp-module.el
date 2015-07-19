;; elisp-module

(require 'package-module)

(defun eval-buff-go-to-repl (arg)
  (interactive "P")
  (save-buffer)
  (progn
    (eval-buffer)
    (when (and arg (get-buffer "*ielm*"))
      (switch-to-buffer-other-window (get-buffer "*ielm*")))))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

(define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buff-go-to-repl)

(define-key emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)

(provide 'elisp-module)
