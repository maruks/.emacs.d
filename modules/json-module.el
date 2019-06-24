;; json-module

(require 'package-module)

(package-require 'json-mode)
(package-require 'flycheck-demjsonlint)

(add-hook 'json-mode-hook
	  (lambda ()
	    (flycheck-mode)))

(provide 'json-module)
