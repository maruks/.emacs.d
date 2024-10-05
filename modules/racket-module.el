;; racket-module

(require 'package-module)

(use-package racket-mode
  :mode ("\\.rkt\\'" . racket-mode)
  :bind (:map racket-mode-map
	      ("C-c C-a" . racket-align)
	      ("C-c C-z" . racket-run-and-switch-to-repl)
	      )

  :diminish (which-key-mode)

  :hook ((racket-mode . racket-xp-mode))

  :custom

  (racket-program "/Applications/Racket v8.14.0.4/bin/racket")

  )

(provide 'racket-module)
