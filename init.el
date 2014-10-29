(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/slime")

;; user details
(setq user-full-name "Maris Orbidans")
(setq user-mail-address "maris.orbidans@gmail.com")

;; repo
(progn
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (defvar my-packages '(clojure-mode
                        scala-mode
			sml-mode
                        ace-jump-mode
                        yasnippet
                        projectile
                        perspective
			exec-path-from-shell
                        popup
                        auto-complete
                        pos-tip
                        ac-slime
			ac-cider
                        fuzzy
			paredit
                        load-theme-buffer-local
                        zenburn-theme
                        solarized-theme
                        magit
			org
                        haskell-mode
                        cider
                        quack
                        geiser
			smart-mode-line
			rich-minority
			ag))
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; projectile
(require 'projectile)
(projectile-global-mode)

;; clojure-mode
(require 'clojure-mode)

(defun compile-buffer (arg) 
  (interactive "P")
  (save-buffer)
  (cider-load-current-buffer)
  (when arg
    (cider-switch-to-relevant-repl-buffer nil)))

(defun compile-run-tests (arg) 
  (interactive "P")
  (save-buffer)
  (cider-load-current-buffer)  
  (cider-interactive-eval "(speclj.core/run-specs)")
  (when arg 
    (cider-switch-to-relevant-repl-buffer nil)))

(defun eval-popup () 
  (interactive)  
  (let* ((result (cider-eval-sync (cider-last-sexp) (cider-find-ns)))
	 (val (plist-get result :value))
	 (err (plist-get result :stderr)))
    (popup-tip
     (or val err))))

(defun clj-insert-fn ()  
  (interactive)  
  (insert "(fn [])")
  (backward-char 2))

(eval-after-load 'clojure-mode
  '(progn  
     (define-key clojure-mode-map (kbd "<f5>") 'compile-buffer)
     (define-key clojure-mode-map (kbd "<f6>") 'compile-run-tests)
     (define-key clojure-mode-map (kbd "\e\ee") 'eval-popup)
     (define-key clojure-mode-map (kbd "\e\er") 'cider-switch-to-relevant-repl-buffer)
     (define-key clojure-mode-map (kbd "\e\ef") 'clj-insert-fn)))

;; emacs lisp
(defun eval-buff-go-to-repl () (interactive)
  (progn
    (eval-buffer)
    (if (get-buffer "*ielm*")
        (switch-to-buffer-other-window (get-buffer "*ielm*")))))

(eval-after-load 'emacs-lisp-mode
  '(define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buff-go-to-repl))

(show-paren-mode 1)

(defun enable-paredit () 
  (paredit-mode 1))

(defvar lisp-mode-hooks
  '(clojure-mode-hook
    cider-repl-mode-hook
    emacs-lisp-mode-hook
    ielm-mode-hook
    lisp-mode-hook
    lisp-interaction-mode-hook
    geiser-repl-mode-hook
    scheme-mode-hook))

(dolist (h lisp-mode-hooks)
  (add-hook h 'enable-paredit))

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
(setq inhibit-startup-screen 1)

(if (and window-system (boundp 'tool-bar-mode))
    (tool-bar-mode -1))
(if
    (boundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq make-backup-files nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(setq tab-width 2
      indent-tabs-mode nil)

(column-number-mode 1)

;; shell fix
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; haskell
(require 'haskell-ac)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(add-to-list 'completion-ignored-extensions ".hi")

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

;; font & hash
(setq font (getenv "EMACS_DEFAULT_FONT"))

(when (eq system-type 'darwin)
  (setq font (or font "Menlo-15"))
  (global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#"))))

(when (eq system-type 'gnu/linux)
  (setq font (or font "DejaVu Sans Mono-10")))

(when font
  (set-default-font font)
  (add-to-list 'default-frame-alist (cons 'font font)))

;; fullscreen on x11
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

;; maxframe
(add-to-list 'load-path "~/.emacs.d/maxframe")
(require 'maxframe)

;; mark
(require 'mark)

;; reformat
(require 'reformat)

;; sudoku
(add-to-list 'load-path "~/.emacs.d/sudoku")
(require 'sudoku)

;; slime
(add-to-list 'load-path "~/.emacs.d/slime")
(setq inferior-lisp-program "sbcl")
(require 'slime)
(slime-setup '(slime-fancy))

;; auto complete
(require 'auto-complete-config)
(require 'pos-tip)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(ac-config-default)
(setq ac-auto-show-menu nil)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;; configure auto complete to work in slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

;; fuzzy search
(require 'fuzzy)

;; yasnippet
(require 'yasnippet)

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

(yas-reload-all)

(add-hook 'clojure-mode-hook
          '(lambda ()
             (yas-minor-mode)))

;; ensime
(defun l0ad-ensime ()
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
  (require 'ensime)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

;; cider
(add-hook 'cider-interaction-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq cider-hide-special-buffers t)
(setq cider-tab-command 'indent-for-tab-command)
(setq cider-popup-stacktraces nil)
(add-hook 'cider-repl-mode-hook 'subword-mode)

(eval-after-load 'cider-repl-mode
  '(define-key cider-repl-mode-map (kbd "s-p") 'cider-previous-input))

;; ac-cider
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-mode))

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".clj" ".js" ".java" ".html" ".xml" ".sh" ".el"))

;; geiser
(setq geiser-active-implementations '(racket))

(defun compile-racket-buffer (arg)
  (interactive "P")
  (save-buffer)
  (geiser-compile-current-buffer)
  (when arg
    (geiser-mode-switch-to-repl nil)))

(eval-after-load 'scheme
  '(progn  
     (define-key scheme-mode-map (kbd "<f5>") 'compile-racket-buffer)     
     (define-key scheme-mode-map (kbd "\e\er") 'geiser-mode-switch-to-repl)
     (define-key scheme-mode-map (kbd "\e\el") (lambda () (interactive) (geiser-insert-lambda t)))))

;; server
(load "server")
(add-hook 'server-switch-hook
              (lambda nil
                (let ((server-buf (current-buffer)))
                  (bury-buffer)
                  (switch-to-buffer-other-frame server-buf))))

(add-hook 'server-done-hook (lambda () (delete-frame)))

(unless (server-running-p) (server-start))

;; global keys

(global-set-key (kbd "\e\em") 'magit-status)
(global-set-key (kbd "\e\ec") 'cider-jack-in)
(global-set-key (kbd "\e\eg") 'goto-line)
(global-set-key (kbd "\e\ed") 'duplicate-current-line)

(global-set-key (kbd "<f8>") 'magit-status)
(global-set-key (kbd "C-c ji") 'cider-jack-in)

(global-set-key (kbd "C-c tf") 'toggle-fullscreen)
(global-set-key (kbd "C-c mf") 'maximize-frame)
(global-set-key (kbd "C-c rf") 'restore-frame)

(global-set-key (kbd "C-c acm") 'auto-complete-mode)
(global-set-key (kbd "C-c fie") 'turn-on-fuzzy-isearch)
(global-set-key (kbd "C-c fid") 'turn-off-fuzzy-isearch)

;; ace jump mode
;; "C-c SPC" => ace-jump-word-mode           Enter first char of a word, select the highlight key to move to.
;; "C-u C-c SPC" => ace-jump-char-mode       Enter a char for query, select the highlight key to move to.
;; "C-u C-u C-c SPC" => ace-jump-line-mode   Each non-empty line will be marked, select the highlight key to move to.
;; "M-`"                                     Jump back

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(add-hook 'ace-jump-mode-before-jump-hook
          (lambda () (push-mark (point) t)))

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; change to home directory
(setq default-directory (concat (getenv "HOME") "/"))

;; M-x re-builder
(require 're-builder)
(setq reb-re-syntax 'string)

;; exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; smart mode line

;;(require 'smart-mode-line)
;;(require 'rich-minority)

;;(setq sml/no-confirm-load-theme t)

;;(sml/setup)

;;(sml/apply-theme 'respectful)

;;(setq sml/shorten-directory t)
;;(setq sml/shorten-modes t)
;;(setq sml/name-width 25)
;;(setq sml/mode-width 'full)

;;(setq rm-blacklist '(" AC" " ElDoc" " yas" " Paredit"))

