;; elisp-module

(require 'package-module)

(defun eval-buff-go-to-repl ()
  (interactive)
  (progn
    (eval-buffer)
    (if (get-buffer "*ielm*")
        (switch-to-buffer-other-window (get-buffer "*ielm*")))))

(eval-after-load 'emacs-lisp-mode
  '(define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buff-go-to-repl))

(provide 'elisp-module)
