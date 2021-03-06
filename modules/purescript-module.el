;; purescript-module

(require 'package-module)

(package-require 'purescript-mode)
(package-require 'psc-ide)
(package-require 'psci)

(require 'psc-ide)

(add-hook 'purescript-mode-hook
	  (lambda ()
	    ;; (setq default-directory
            ;;       (locate-dominating-file default-directory "bower.json"))
	    (psc-ide-mode)
	    (company-mode)
	    (flycheck-mode)
	    (turn-on-purescript-indentation)
	    (define-key purescript-mode-map (kbd "TAB") #'company-indent-or-complete-common)
	    (define-key purescript-mode-map [?\s-c] #'psc-ide-rebuild)))

(provide 'purescript-module)
