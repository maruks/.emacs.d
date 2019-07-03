;; appearance-module

(require 'package-module)

(menu-bar-mode -1)
(setq inhibit-startup-screen 1)

(when (and window-system (boundp 'tool-bar-mode))
  (tool-bar-mode -1))

(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(show-paren-mode 1)

;; (defun psm ()
;;   (push '("->" . ?→) prettify-symbols-alist)
;;   (push '("<-" . ?←) prettify-symbols-alist)
;;   (prettify-symbols-mode 1))

;; (when (fboundp 'prettify-symbols-mode)
;;   (add-hook 'clojure-mode-hook 'prettify-symbols-mode)
;;   (add-hook 'lisp-mode-hook 'prettify-symbols-mode)
;;   (add-hook 'emacs-lisp-mode-hook 'prettify-symbols-mode)
;;   (add-hook 'erlang-mode-hook 'psm)
;;   (add-hook 'haskell-mode-hook 'psm))

(provide 'appearance-module)
