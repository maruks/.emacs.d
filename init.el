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
(require 'clojure-mode)

(fset 'compile-and-goto-repl "\C-x\C-s\C-c\C-k\C-c\C-z")

(global-set-key (kbd "C-c C-j C-i") 'clojure-jack-in)

(add-hook 'clojure-mode-hook
          '(lambda () (define-key clojure-mode-map (kbd "<f5>") 'compile-and-goto-repl)))

;; emacs lisp
(defun eval-buff-go-to-repl () (interactive) 
  (progn 
    (eval-buffer) 
    (if (get-buffer "*ielm*")
	(switch-to-buffer-other-window (get-buffer "*ielm*")))))

(add-hook 'emacs-lisp-mode-hook
          '(lambda () (define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buff-go-to-repl)))

;; paredit
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
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(setq current-t43m3 nil)

(defun enab-theme (theme) 
  (if current-t43m3 (disable-theme current-t43m3))
  (setq current-t43m3 theme) 
  (load-theme theme t)) 

(defun disab-current-theme () 
  (if current-t43m3 (disable-theme current-t43m3))
  (setq current-t43m3 nil))

(global-set-key (kbd "C-c ltwo") '(lambda () (interactive) (enab-theme 'wombat)))
(global-set-key (kbd "C-c ltze") '(lambda () (interactive) (enab-theme 'zenburn)))
(global-set-key (kbd "C-c ltsd") '(lambda () (interactive) (enab-theme 'solarized-dark)))
(global-set-key (kbd "C-c ltsl") '(lambda () (interactive) (enab-theme 'solarized-light)))
(global-set-key (kbd "C-c ltne") '(lambda () (interactive) (enab-theme 'tomorrow-night-eighties)))
(global-set-key (kbd "C-c ltni") '(lambda () (interactive) (enab-theme 'tomorrow-night)))
(global-set-key (kbd "C-c ltnb") '(lambda () (interactive) (enab-theme 'tomorrow-night-bright)))
(global-set-key (kbd "C-c ltto") '(lambda () (interactive) (enab-theme 'tomorrow)))
(global-set-key (kbd "C-c ltta") '(lambda () (interactive) (enab-theme 'tango)))
(global-set-key (kbd "C-c ltdb") '(lambda () (interactive) (enab-theme 'deeper-blue)))
(global-set-key (kbd "C-c ltdi") '(lambda () (interactive) (enab-theme 'dichromacy)))

(global-set-key (kbd "C-c dct") '(lambda () (interactive) (disab-current-theme)))

;; windmove and framemove
(add-to-list 'load-path "~/.emacs.d/framemove")
(require 'framemove)
(windmove-default-keybindings)
(setq framemove-hook-into-windmove t)

;; customizations
(menu-bar-mode -1) 
(show-paren-mode t)
(if (and window-system (boundp 'tool-bar-mode))
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

;; maxframe
(add-to-list 'load-path "~/.emacs.d/maxframe")
(require 'maxframe)
(global-set-key (kbd "C-c mf") 'maximize-frame)
(global-set-key (kbd "C-c rf") 'restore-frame)

;; slime
(defun load-slime ()
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/slime")
  (setq inferior-lisp-program "/opt/local/bin/sbcl")
  (require 'slime)
  (slime-setup '(slime-fancy)))

;; slime 2010 (for clojure)
(defun load-slime-2010 ()
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/slime-20100404.1")
  (add-to-list 'load-path "~/.emacs.d/slime-repl-20100404")
  (require 'slime)
  (slime-setup '(slime-repl)))

;; auto complete
(require 'auto-complete-config)
(require 'pos-tip)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(ac-config-default)
(setq ac-auto-show-menu nil)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(global-set-key (kbd "C-c acm") 'auto-complete-mode)

;; configure auto complete to work in slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

;; fuzzy search
(require 'fuzzy)
(global-set-key (kbd "C-c fie") 'turn-on-fuzzy-isearch)
(global-set-key (kbd "C-c fid") 'turn-off-fuzzy-isearch)

;; yasnippet
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

;; ensime

;;(add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
;;(require 'ensime)

;;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

