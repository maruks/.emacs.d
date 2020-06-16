;; json-module

(require 'package-module)

(package-require 'json-mode)

(add-hook 'json-mode-hook
	  (lambda ()
	    (flycheck-mode)))

(provide 'json-module)
