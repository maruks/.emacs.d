(add-to-list 'load-path "~/.emacs.d/lisp")

;; user details
(setq user-full-name "Maris Orbidans")
(setq user-mail-address "maris.orbidans@gmail.com")

;; repo
(progn
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/") t)
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
			slime
                        slime-company
			company
                        fuzzy
			paredit
                        load-theme-buffer-local
                        zenburn-theme
                        solarized-theme
                        magit
			org
                        haskell-mode
                        cider
			clj-refactor
                        quack
                        geiser
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
  (cider-load-buffer)
  (when arg
    (cider-switch-to-relevant-repl-buffer nil)))

(defun compile-run-tests (arg) 
  (interactive "P")
  (save-buffer)
  (cider-load-buffer)  
  (cider-interactive-eval "(speclj.core/run-specs)")
  (when arg 
    (cider-switch-to-relevant-repl-buffer nil)))

(defun clj-insert-fn ()  
  (interactive)  
  (insert "(fn [])")
  (backward-char 2))

(eval-after-load 'clojure-mode
  '(progn  
     (define-key clojure-mode-map (kbd "<f5>") 'compile-buffer)
     (define-key clojure-mode-map (kbd "<f6>") 'compile-run-tests)
     (define-key clojure-mode-map (kbd "\e\er") 'cider-switch-to-relevant-repl-buffer)
     (define-key clojure-mode-map (kbd "\e\ef") 'clj-insert-fn)))

;; sml
(defun save-and-load-file (arg)
  (interactive "P")
  (save-buffer)
  (sml-prog-proc-load-file (buffer-file-name) (not arg)))

(eval-after-load 'sml-mode
  '(progn  
     (define-key sml-mode-map (kbd "<f5>") 'save-and-load-file)))

;; emacs lisp
(defun eval-buff-go-to-repl ()
  (interactive)
  (progn
    (eval-buffer)
    (if (get-buffer "*ielm*")
        (switch-to-buffer-other-window (get-buffer "*ielm*")))))

(eval-after-load 'emacs-lisp-mode
  '(define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buff-go-to-repl))

(show-paren-mode 1)

(defun enable-paredit () 
  (paredit-mode 1)
  (prettify-symbols-mode 1))

(defvar lisp-mode-hooks
  '(clojure-mode-hook
    cider-repl-mode-hook
    slime-repl-mode-hook
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
  (setq font (or font "Menlo-15")) ;; Source Code Pro-15
  (global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#"))))

(when (eq system-type 'gnu/linux)
  (setq font (or font "DejaVu Sans Mono-10")))

(when font
  (set-frame-font font nil t))

;; mark
(require 'mark)

;; reformat
(require 'reformat)

;; sudoku
(add-to-list 'load-path "~/.emacs.d/sudoku")
(require 'sudoku)

;; slime
(require 'slime)
(require 'slime-company)
(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-asdf slime-sbcl-exts slime-company))

;; fuzzy search
(require 'fuzzy)

;; yasnippet
(require 'yasnippet)

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

(yas-reload-all)

(add-hook 'clojure-mode-hook
          '(lambda ()
             (yas-minor-mode)))

;; clj-refactor
(require 'clj-refactor)

(add-hook 'clojure-mode-hook
          (lambda ()
	    (clj-refactor-mode 1)
	    (cljr-add-keybindings-with-prefix "C-c C-a")))

;; ensime
(defun l0ad-ensime ()
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
  (require 'ensime)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

;; cider
(add-hook 'cider-mode-hook #'eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-show-error-buffer 'except-in-repl)
(add-hook 'cider-repl-mode-hook #'subword-mode)

;; company mode
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

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

(global-set-key (kbd "C-c tf") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-c tm") 'toggle-frame-maximized)

(global-set-key (kbd "C-c fie") 'turn-on-fuzzy-isearch)
(global-set-key (kbd "C-c fid") 'turn-off-fuzzy-isearch)

(global-set-key [C-prior] 'previous-buffer)
(global-set-key [C-next] 'next-buffer)

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
(require 'mode-line)

(setq prev-mode-line nil)

(defun change-mode-line ()
  (interactive)
  (if prev-mode-line
      (progn
	(setq-default mode-line-format prev-mode-line)
	(setq prev-mode-line nil))
      (progn
        (setq prev-mode-line mode-line-format)
        (setq-default mode-line-format (better-mode-line)))))

(change-mode-line)

;; erlang
(defun compile-erlang-buffer (arg)
  (interactive "P")
  (save-buffer)
  (erlang-compile)
  (when arg 
    (switch-to-buffer-other-window "*erlang*")))

(defun compile-erlang-buffer-and-test (arg)
  (interactive "P")
  (save-buffer)
  (erlang-eunit-compile-and-run-module-tests)
  (when arg 
    (switch-to-buffer-other-window "*erlang*")))

(defun erlang-paredit ()
  (progn
    (define-key erlang-mode-map [?\(] 'paredit-open-parenthesis)
    (define-key erlang-mode-map [?\[] 'paredit-open-square)
    (define-key erlang-mode-map [?\{] 'paredit-open-curly)
    (define-key erlang-mode-map [?\)] 'paredit-close-parenthesis)
    (define-key erlang-mode-map [?\}] 'paredit-close-curly)
    (define-key erlang-mode-map [?\]] 'paredit-close-square)
    (set (make-local-variable 'paredit-space-for-delimiter-predicates) '((lambda (endp delimiter) nil)))))

(add-hook 'erlang-mode-hook
	  (lambda ()
	    (define-key erlang-mode-map (kbd "<f5>") 'compile-erlang-buffer)
	    (define-key erlang-mode-map (kbd "<f6>") 'compile-erlang-buffer-and-test)	    
	    (enable-paredit)
	    (erlang-paredit)))

(defun l0ad-erlang ()
  (interactive)
  (let* ((erlang-root (or (getenv "_KERL_ACTIVE_DIR")  "/usr/local/lib/erlang"))
	 (erlang-tools (concat erlang-root "/lib/tools-2.7.1/emacs")))
    (setq load-path (cons erlang-tools load-path))
    (setq erlang-root-dir erlang-root)    
    (setq exec-path (cons (concat erlang-root-dir "/bin") exec-path)))
  (require 'erlang-start)
  (require 'erlang-eunit)
  (setq inferior-erlang-machine-options '("-sname" "emacs")))

;; distel

(defun l0ad-distel ()
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/distel/elisp")
  (require 'distel)
  (distel-setup)

  (defvar inferior-erlang-prompt-timeout t)
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  (setq erl-nodename-cache
	(make-symbol
	 (concat
	  "emacs@"
	  (car (split-string (shell-command-to-string "hostname")))))))

;; mit-scheme
(setq scheme-program-name "/Applications/mit-scheme/Contents/Resources/mit-scheme")
(require 'xscheme)
