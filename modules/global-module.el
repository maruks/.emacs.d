;; global-module

(require 'package-module)

(package-require 'ace-jump-mode)
(package-require 'projectile)
(package-require 'popup-imenu)

(package-require 'exec-path-from-shell)
(package-require 'company)
(package-require 'org)
(package-require 'ag)
(package-require 'flx-ido)
(package-require 'crux)

(package-require 'rainbow-mode)

(defalias 'yes-or-no-p 'y-or-n-p)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq tab-width 2
      indent-tabs-mode nil)

(column-number-mode 1)

;; shell fix
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; windmove and framemove
(add-to-list 'load-path "~/.emacs.d/vendor/framemove")
(require 'framemove)
(windmove-default-keybindings)
(setq framemove-hook-into-windmove t)

;; server
(load "server")
(add-hook 'server-switch-hook
              (lambda nil
                (let ((server-buf (current-buffer)))
                  (bury-buffer)
                  (switch-to-buffer-other-frame server-buf))))

(add-hook 'server-done-hook (lambda () (delete-frame)))

(unless (server-running-p) (server-start))

;; ido
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".clj" ".cljs" ".erl" ".hs" ".js" ".java" ".html" ".xml" ".sh" ".el" ".erl"))

(setq ido-use-faces nil)
;(setq flx-ido-use-faces nil)

(ido-mode 1)
(flx-ido-mode 1)

;; sudoku
(add-to-list 'load-path "~/.emacs.d/vendor/sudoku")
(require 'sudoku)

;; mark
(add-to-list 'load-path "~/.emacs.d/vendor/mark")
(require 'mark)

;; reformat
(add-to-list 'load-path "~/.emacs.d/vendor/reformat")
(require 'reformat)

;; change to home directory
(setq default-directory (concat (getenv "HOME") "/"))

;; ace jump mode
;; "C-c s-j" => ace-jump-word-mode           Enter first char of a word, select the highlight key to move to.
;; "C-u C-c s-j" => ace-jump-char-mode       Enter a char for query, select the highlight key to move to.
;; "C-u C-u C-c s-j" => ace-jump-line-mode   Each non-empty line will be marked, select the highlight key to move to.
;; "M-`"                                     Jump back

(define-key global-map (kbd "s-j") 'ace-jump-mode)

(add-hook 'ace-jump-mode-before-jump-hook
          (lambda () (push-mark (point) t)))

;; imenu
(define-key global-map (kbd "M-i") 'popup-imenu)

;; M-x re-builder
(require 're-builder)
(setq reb-re-syntax 'string)

;; exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; projectile
(require 'projectile)
(projectile-global-mode)

;; prefix
(define-key projectile-mode-map (kbd "s-p") #'projectile-command-map)

;; create test files
(setq projectile-create-missing-test-files t)

;; port install the_silver_searcher
(define-key projectile-mode-map [?\s-a] 'projectile-ag)
(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-b] 'projectile-switch-to-buffer)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map (kbd "\e\et") 'projectile-find-implementation-or-test-other-window)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)
(define-key projectile-mode-map [?\s-r] 'projectile-replace)

;; ag
(setq ag-reuse-buffers 't)

;; global keys
(global-set-key (kbd "\e\eg") 'goto-line)

(global-set-key (kbd "C-c tf") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-c tm") 'toggle-frame-maximized)

;; line numbers
(global-set-key (kbd "s-4") 'display-line-numbers-mode )

;; kill-processes
(setq confirm-kill-processes nil)

;; C - pg up / pg down
(global-set-key [C-prior] 'previous-buffer)
(global-set-key [C-next] 'next-buffer)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "s-i") 'ibuffer)

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("org" (mode . org-mode))
               ("dired" (mode . dired-mode))
               ("clojure" (or (mode . clojure-mode)
			      (mode . clojurec-mode)))
               ("clojure script" (mode . clojurescript-mode))
               ("js" (mode . js2-mode))
	       ("erlang" (mode . erlang-mode))
	       ("elixir" (mode . elixir-mode))
	       ("haskell" (mode . haskell-mode))
               ("emacs" (or
                         (name . "^.+\\.el$")
                         (name . "^\\*.+\\*$")))))))

;; xah-find-text
;; xah-find-text-regex
;; xah-find-count
;; xah-find-replace-text
;; xah-find-replace-text-regex
(package-require 'xah-find)

;; symbol search
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Symbol-Search.html

(global-set-key (kbd "C-c s") 'isearch-forward-symbol)
(global-set-key (kbd "C-c .") 'isearch-forward-symbol-at-point)

;; which key
(package-require 'which-key)
(require 'which-key)
(which-key-mode)

;; whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; disable bell
(setq ring-bell-function 'ignore)

;; remove custom from init.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; wheel
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(global-set-key (kbd "M-[") 'backward-paragraph)
(global-set-key (kbd "M-]") 'forward-paragraph)

(global-set-key (kbd "M-{") 'backward-sentence)
(global-set-key (kbd "M-}") 'forward-sentence)

;; crux
(global-set-key (kbd "C-c D") #'crux-delete-file-and-buffer)
(global-set-key (kbd "s-k") #'crux-kill-whole-line)
(global-set-key (kbd "\e\ed") 'crux-duplicate-current-line-or-region)
(global-set-key (kbd "C-x 4 t") 'crux-transpose-windows)

(setq next-line-add-newlines t)

;; used in advice
(defun save-current-buffer-if-modified (&rest args)
  (when (and buffer-file-name (buffer-modified-p))
    (save-buffer)))

(defun print-to-scratch (string)
  (save-excursion
   (set-buffer "*scratch*")
   (insert (format "%s" string))))

(provide 'global-module)
