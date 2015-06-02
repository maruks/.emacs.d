;; flycheck-module

(require 'package-module)

(package-require 'flycheck)

(add-hook 'erlang-mode-hook
	  (lambda ()
	    (flycheck-mode)))

(provide 'flycheck-module)
