;; racket-module

(require 'package-module)

(package-require 'geiser)

(setq geiser-active-implementations '(racket))

(defun compile-racket-buffer (arg)
  (interactive "P")
  (save-buffer)
  (geiser-compile-current-buffer)
  (when arg
    (geiser-mode-switch-to-repl nil)))

(eval-after-load 'scheme
  '(progn
     (define-key scheme-mode-map (kbd "<f5>") 'compile-racket-buffer)
     (define-key scheme-mode-map (kbd "\e\er") 'geiser-mode-switch-to-repl)
     (define-key scheme-mode-map (kbd "\e\el") (lambda () (interactive) (geiser-insert-lambda t)))))

(provide 'racket-module)
