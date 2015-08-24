;; electric-pair-module

(require 'package-module)

(add-hook 'erlang-mode-hook
	  (lambda () (electric-pair-mode 1)))

(add-hook 'python-mode-hook
	  (lambda () (electric-pair-mode 1)))

(provide 'electric-pair-module)
