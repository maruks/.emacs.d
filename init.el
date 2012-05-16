(add-to-list 'load-path "~/.emacs.d/")

;; repo
(progn
  (require 'package)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (defvar my-packages '(clojure-mode
			scala-mode
			yasnippet
			projectile
			popup
			auto-complete
			pos-tip
			ac-slime
			fuzzy
			paredit
			load-theme-buffer-local
			zenburn-theme
			solarized-theme
			magit))
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; projectile
(require 'projectile)
(projectile-global-mode)

;; magit
(global-set-key (kbd "<f6>") 'magit-status)

;; clojure-mode
(add-to-list 'load-path "~/.emacs.d/elpa/clojure-mode-1.11.4")
(require 'clojure-mode)

(fset 'compile-and-goto-repl "\C-x\C-s\C-c\C-k\C-c\C-z")

(global-set-key (kbd "C-c C-j C-i") 'clojure-jack-in)

(add-hook 'clojure-mode-hook
          '(lambda () (define-key clojure-mode-map (kbd "<f5>") 'compile-and-goto-repl)))

;; emacs lisp
(defun eval-buff-go-to-repl () (interactive) (progn 
					       (eval-buffer) 
					       (if (get-buffer "*ielm*")
						   (switch-to-buffer-other-window (get-buffer "*ielm*")))))
(add-hook 'emacs-lisp-mode-hook
          '(lambda () (define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buff-go-to-repl)))

;; paredit
(add-to-list 'load-path "~/.emacs.d/elpa/paredit-22")

(autoload 'paredit-mode "paredit"  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       '(lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             '(lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook '(lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           '(lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook          '(lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook       '(lambda () (paredit-mode +1)))

(global-set-key (kbd "C-c pme") '(lambda () (paredit-mode +1)))
(global-set-key (kbd "C-c pmd") '(lambda () (paredit-mode -1)))

;; color themes
(global-set-key (kbd "C-c ltw") '(lambda () (interactive) (load-theme 'wombat t)))
(global-set-key (kbd "C-c ltz") '(lambda () (interactive) (load-theme 'zenburn t)))
(global-set-key (kbd "C-c ltsd") '(lambda () (interactive) (load-theme 'solarized-dark t)))
(global-set-key (kbd "C-c ltsl") '(lambda () (interactive) (load-theme 'solarized-light t)))
(global-set-key (kbd "C-c ltta") '(lambda () (interactive) (load-theme 'tango t)))
(global-set-key (kbd "C-c ltdb") '(lambda () (interactive) (load-theme 'deeper-blue t)))
(global-set-key (kbd "C-c ltdi") '(lambda () (interactive) (load-theme 'dichromacy t)))

(global-set-key (kbd "C-c dtw") '(lambda () (interactive) (disable-theme 'wombat)))
(global-set-key (kbd "C-c dtz") '(lambda () (interactive) (disable-theme 'zenburn)))
(global-set-key (kbd "C-c dtsd") '(lambda () (interactive) (disable-theme 'solarized-dark)))
(global-set-key (kbd "C-c dtsl") '(lambda () (interactive) (disable-theme 'solarized-light)))
(global-set-key (kbd "C-c dtta") '(lambda () (interactive) (disable-theme 'tango)))
(global-set-key (kbd "C-c dtdb") '(lambda () (interactive) (disable-theme 'deeper-blue)))
(global-set-key (kbd "C-c dtdi") '(lambda () (interactive) (disable-theme 'dichromacy)))

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

;; font & hash
(if (eq system-type 'darwin)
    (progn  
      (set-default-font "Menlo-14")
      (add-to-list 'default-frame-alist '(font . "Menlo-14"))
      (global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))))

;; frame size
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (let ((width (x-display-pixel-width)) 
	    (height (x-display-pixel-height)))
	(add-to-list 'default-frame-alist 
		     (cons 'top 0))
	(add-to-list 'default-frame-alist 
		     (cons 'left 0))
	(add-to-list 'default-frame-alist 
		     (cons 'width (/ (- width (/ width 8))  
				     (frame-char-width))))
	(add-to-list 'default-frame-alist 
		     (cons 'height (/ (- height (/ height 8))
				      (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;; auto complete
(require 'auto-complete-config)
(require 'pos-tip)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(ac-config-default)
(setq ac-auto-show-menu nil)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(global-set-key (kbd "C-c acm") 'auto-complete-mode)

;; configure auto complete to work in slime
(add-to-list 'load-path "~/.emacs.d/elpa/ac-slime-0.1")
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

;; fuzzy search
(require 'fuzzy)
(global-set-key (kbd "C-c fie") 'turn-on-fuzzy-isearch)
(global-set-key (kbd "C-c fid") 'turn-off-fuzzy-isearch)

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.6.1")
(require 'yasnippet) 
(yas/initialize)
(setq yas/root-directory '("~/.emacs.d/elpa/yasnippet-0.6.1/snippets"
                           "~/.emacs.d/snippets"))

(mapc 'yas/load-directory yas/root-directory)

;; backups
(setq make-backup-files t
      backup-by-copying t     
      backup-directory-alist '(("." . "~/.emacs.d/backups")) 
      version-control t
      kept-new-versions 2
      kept-old-versions 5
      delete-old-versions t)
