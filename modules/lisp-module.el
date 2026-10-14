;; -*- lexical-binding: t; -*-
;; lisp-module

(require 'package-module)

(use-package sly
  :mode ("\\.lisp\\'" . lisp-mode)
  :ensure t
  :bind (:map lisp-mode-map
	      ("s-c" . sly-compile-and-load-file)
	      ("s-s s-s" . sly-scratch))

  :diminish (which-key-mode)

  :hook ((sly-mrepl . my-sly-mrepl-setup)
         (lisp-mode . my-lisp-mode-setup))

  :init
  (setf sly-lisp-implementations '((sbcl ("sbcl") :coding-system utf-8-unix)
				   (ccl ("ccl") :coding-system utf-8-unix)))

  (setf sly-complete-symbol-function #'sly-flex-completions)

  :config
  (bind-lisp-snippets lisp-mode-map)
  (advice-add 'sly-compile-and-load-file :before #'save-current-buffer-if-modified)

  ;; local hyperspec
  ;; (ql:quickload "clhs")
  (load (expand-file-name "~/quicklisp/clhs-use-local.el") t)

  (defun my-sly-start (implementation)
    (interactive
     (list (intern
            (completing-read
             "Lisp implementation: "
             (mapcar #'symbol-name
                     (mapcar #'car sly-lisp-implementations))
             nil t))))
    (let ((sly-default-lisp implementation))
      (sly)))

  (defun my-sly-sbcl ()
    (interactive)
    (my-sly-start 'sbcl))

  (defun my-sly-ccl ()
    (interactive)
    (my-sly-start 'ccl)))

(use-package company
  :ensure t
  :hook ((lisp-mode . company-mode)
         (sly-mrepl-mode . company-mode))
  :bind (:map lisp-mode-map
         ("TAB" . company-indent-or-complete-common)))


(use-package sly-asdf
  :after sly)

;; M-x sly-quickload
;; C-c C-d C-q
(use-package sly-quicklisp
  :ensure t
  :after sly)

(defun my-lisp-mode-setup ()
  (when (fboundp 'yas-minor-mode)
    (yas-minor-mode 1)))

(defun my-sly-mrepl-setup ()
  (when (boundp 'sly-mrepl-mode-map)
    (define-key sly-mrepl-mode-map
                (kbd "C-c C-o")
                #'sly-mrepl-clear-repl)))

(provide 'lisp-module)
