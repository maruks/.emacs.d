(add-to-list 'load-path "~/.emacs.d/")

;; repo
(progn
  (require 'package)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (defvar my-packages '(clojure-mode
			paredit
			magit))
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; clojure-mode
(add-to-list 'load-path "~/.emacs.d/elpa/clojure-mode-1.11.4")
(require 'clojure-mode)

(fset 'compile-and-goto-repl "\C-x\C-s\C-c\C-k\C-c\C-z")

(global-set-key (kbd "C-c C-j C-i") 'clojure-jack-in)

(add-hook 'clojure-mode-hook
          '(lambda () (define-key clojure-mode-map (kbd "C-c C-g C-r") 'compile-and-goto-repl)))

;; emacs lisp

(defun eval-buff-go-to-repl () (progn (eval-buffer) (switch-to-buffer (get-buffer "*ielm*"))))
(add-hook 'emacs-lisp-mode-hook
          '(lambda () (define-key emacs-lisp-mode-map (kbd "C-c C-g C-r") (eval-buff-go-to-repl))))

;; paredit
(add-to-list 'load-path "~/.emacs.d/elpa/paredit-22")

(autoload 'paredit-mode "paredit"  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))

(global-set-key (kbd "C-c C-p C-e") (lambda () (paredit-mode +1)))
(global-set-key (kbd "C-c C-p C-d") (lambda () (paredit-mode -1)))

;; color themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(defun load-zenburn () (interactive) (load-theme 'zenburn t))
(defun load-sol-dark () (interactive) (load-theme 'solarized-dark t) )
(defun load-sol-light () (interactive) (load-theme 'solarized-light t))

(global-set-key (kbd "C-c C-t C-z") 'load-zenburn)
(global-set-key (kbd "C-c C-t C-s") 'load-sol-dark)
(global-set-key (kbd "C-c C-t C-l") 'load-sol-light)

;; windmove and framemove
(add-to-list 'load-path "~/.emacs.d/framemove")
(require 'framemove)
(windmove-default-keybindings)
(setq framemove-hook-into-windmove t)

;; customizations
(menu-bar-mode -1) 
(show-paren-mode t)
(if 
    (boundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if 
    (boundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;; shell fix
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

 ;; duplicate current line
(defun duplicate-current-line (&optional n)
  "duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((nb (or n 1))
	  (current-line (thing-at-point 'line)))
      (when (or (= 1 (forward-line 1)) (eq (point) (point-max)))
	(insert "\n"))
      (while (> n 0)
	(insert current-line)
	(decf n)))))
    
(global-set-key (kbd "C-c C-d") 'duplicate-current-line)

;; font
(if (eq system-type 'darwin)
    (set-default-font "Menlo-14"))
