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
			ace-jump-mode
			exec-path-from-shell
			yasnippet
			projectile
			perspective
			popup
			auto-complete
			pos-tip
			ac-slime
			fuzzy
			paredit
			load-theme-buffer-local
			zenburn-theme
			solarized-theme
			magit
			nrepl
			ac-nrepl))
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; projectile
(require 'projectile)
(projectile-global-mode)

;; ace jump mode
;; "C-c SPC" => ace-jump-word-mode           Enter first char of a word, select the highlight key to move to.
;; "C-u C-c SPC" => ace-jump-char-mode       Enter a char for query, select the highlight key to move to.
;; "C-u C-u C-c SPC" => ace-jump-line-mode   Each non-empty line will be marked, select the highlight key to move to.
;; "M-`"                                     Jump backdddd

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(add-hook 'ace-jump-mode-before-jump-hook
	  (lambda () (push-mark (point) t)))

;; magit
(global-set-key (kbd "<f6>") 'magit-status)

;; clojure-mode
(require 'clojure-mode)

(fset 'compile-and-goto-repl "\C-x\C-s\C-c\C-k\C-c\C-z")

(global-set-key (kbd "C-c ji") 'nrepl-jack-in)

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
(add-hook 'emacs-lisp-mode-hook       'paredit-mode)
(add-hook 'lisp-mode-hook             'paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'paredit-mode)
(add-hook 'scheme-mode-hook           'paredit-mode)
(add-hook 'clojure-mode-hook          'paredit-mode)
(add-hook 'slime-repl-mode-hook       'paredit-mode)
(add-hook 'nrepl-mode-hook            'paredit-mode)

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

(defun l0ad-theme (name) 
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
			     (mapcar 'symbol-name (custom-available-themes))))))
  (enab-theme name))

(setq d3fault-theme (getenv "EMACS_DEFAULT_THEME"))

(when d3fault-theme
  (enab-theme (intern d3fault-theme)))

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

(setq font (getenv "EMACS_DEFAULT_FONT"))

(when (eq system-type 'darwin)
  (setq font (or font "Menlo-14"))
  (global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#"))))

(when (eq system-type 'gnu/linux)
  (setq font (or font "DejaVu Sans Mono-10")))

(when font
  (set-default-font font)
  (add-to-list 'default-frame-alist (cons 'font font)))

;; maxframe
(add-to-list 'load-path "~/.emacs.d/maxframe")
(require 'maxframe)
(global-set-key (kbd "C-c mf") 'maximize-frame)
(global-set-key (kbd "C-c rf") 'restore-frame)

;; mark

(require 'mark)

;; sudoku

(add-to-list 'load-path "~/.emacs.d/sudoku")
(require 'sudoku)

;; slime
(defun l0ad-slime ()
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/slime")
  (setq inferior-lisp-program "sbcl")
  (require 'slime)
  (slime-setup '(slime-fancy)))

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

;; ensime
(defun l0ad-ensime () 
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
  (require 'ensime)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

;; nrepl
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq nrepl-tab-command 'indent-for-tab-command)
(setq nrepl-popup-stacktraces nil)
(add-hook 'nrepl-mode-hook 'subword-mode)

;; exec-path-from-shell

(when (memq window-system '(mac ns)) 
  (exec-path-from-shell-initialize))

;; ac-nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))

;; server
(load "server")
(unless (server-running-p) (server-start))
