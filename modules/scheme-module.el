;; scheme-module

(require 'package-module)

(package-require 'geiser)
(package-require 'ac-geiser)

(setq geiser-chez-binary "chez")
(setq geiser-active-implementations '(chez guile racket))

(defun compile-scheme-buffer (arg)
  (interactive "P")
  (save-buffer)
  (geiser-compile-current-buffer)
  (when arg
    (geiser-mode-switch-to-repl nil)))

(eval-after-load 'scheme
  '(progn
     (define-key scheme-mode-map (kbd "<f5>") 'compile-scheme-buffer)
     (define-key scheme-mode-map (kbd "s-c") 'compile-scheme-buffer)
     (define-key scheme-mode-map (kbd "\e\er") 'geiser-mode-switch-to-repl)
     (define-key scheme-mode-map (kbd "\e\el") (lambda () (interactive) (geiser-insert-lambda t)))))

(provide 'scheme-module)
