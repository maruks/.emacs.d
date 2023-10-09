;; global-module

(require 'package-module)

(package-require 'company)
(package-require 'org)

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

;; sudoku
(add-to-list 'load-path "~/.emacs.d/vendor/sudoku")
(require 'sudoku)

;; mark
(add-to-list 'load-path "~/.emacs.d/vendor/mark")
(require 'mark)

;; mark
(add-to-list 'load-path "~/.emacs.d/vendor/xah-mark")
(require 'xah-mark)

;; change to home directory
(setq default-directory (concat (getenv "HOME") "/"))

;; M-x re-builder
(require 're-builder)
(setq reb-re-syntax 'string)

;; exec-path-from-shell
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  ;; :config
  ;; (exec-path-from-shell-initialize)   SLOW
  )

;; global keys

(keymap-global-set "M-3" "#")

(keymap-global-set "ESC ESC g" 'goto-line)

(keymap-global-set "C-c t f" 'toggle-frame-fullscreen)
(keymap-global-set "C-c t m" 'toggle-frame-maximized)

;; line numbers
(keymap-global-set "s-3" 'display-line-numbers-mode)

;; kill-processes
(setq confirm-kill-processes nil)

;; C - pg up / pg down
(keymap-global-set "C-<prior>" 'previous-buffer)
(keymap-global-set "C-<next>" 'next-buffer)

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

;; symbol search
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Symbol-Search.html

(keymap-global-set "C-c s" 'isearch-forward-symbol)
(keymap-global-set "C-c ." 'isearch-forward-symbol-at-point)

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

(keymap-global-set "M-[" 'backward-paragraph)
(keymap-global-set "M-]" 'forward-paragraph)

(keymap-global-set "M-{" 'backward-sentence)
(keymap-global-set "M-}" 'forward-sentence)

;; crux
(use-package crux
  :bind
  (("C-c D" . crux-delete-file-and-buffer)
   ("s-k" . crux-kill-whole-line)
   ("s-d" . crux-duplicate-current-line-or-region)
   ("C-x 4 t" . crux-transpose-windows)))

;; M-w C-w M-; works on single line
(use-package whole-line-or-region
  :ensure t
  :init
  (whole-line-or-region-global-mode))

(setq next-line-add-newlines t)

;; brew install coreutils
(setq insert-directory-program (executable-find "gls"))

;;keep cursor at same position when scrolling
(setq scroll-preserve-screen-position 1)
;;scroll window up/down by one line
(keymap-global-set "M-n" "C-u 1 C-v")
(keymap-global-set "M-p" "C-u 1 M-v")

;; used in advice
(defun save-current-buffer-if-modified (&rest args)
  (when (and buffer-file-name (buffer-modified-p))
    (save-buffer)))

(defun print-to-scratch (string)
  (save-excursion
   (set-buffer "*scratch*")
   (insert (format "%s" string))))

(setq-default with-editor-emacsclient-executable "/usr/local/bin/emacsclient")

(use-package deft
  :bind ("s-4" . deft)
  :ensure t
  :commands (deft)
  :config
  (setq deft-recursive t)
  (setq deft-use-filename-as-title t))

(keymap-global-set "s-0" 'server-edit)

(provide 'global-module)
