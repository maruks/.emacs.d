(require 'package-module)

(package-require 'js2-mode)
(package-require 'moz)  ;; requires MozRepl firefox plugin

;; C-c C-s: open a MozRepl interaction buffer and switch to it
;; C-c C-l: save the current buffer and load it in MozRepl
;; C-M-x: send the current function (as recognized by c-mark-function) to MozRepl
;; C-c C-c: send the current function to MozRepl and switch to the interaction buffer
;; C-c C-r: send the current region to MozRepl

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . js2-mode))

(setq-default
 js2-mode-indent-ignore-first-tab t
 js2-strict-inconsistent-return-warning nil
 js2-global-externs '("module" "require" "__dirname" "process" "console" "JSON" "$" "_"))
 ;; js2-show-parse-errors nil
 ;; js2-strict-var-hides-function-arg-warning nil
 ;; js2-strict-missing-semi-warning nil
 ;; js2-strict-trailing-comma-warning nil
 ;; js2-strict-cond-assign-warning nil
 ;; js2-strict-var-redeclaration-warning nil

(package-require 'tern)
(add-hook 'js2-mode-hook
	  (lambda ()
	    (tern-mode t)))

(with-eval-after-load "company"
  (package-require 'company-tern)
  (require 'company-tern)
  (add-to-list 'company-backends 'company-tern))

(package-require 'js2-refactor)

(add-hook 'js2-mode-hook
          (lambda ()
	    (moz-minor-mode 1)
            (js2r-add-keybindings-with-prefix "C-c C-m")))

(setq js-indent-level 2)

(provide 'javascript-module)
