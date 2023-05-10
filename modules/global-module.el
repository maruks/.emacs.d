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
(global-set-key (kbd "\e\eg") 'goto-line)

(global-set-key (kbd "C-c tf") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-c tm") 'toggle-frame-maximized)

;; line numbers
(global-set-key (kbd "s-5") 'display-line-numbers-mode )

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
(use-package crux
  :bind
  (("C-c D" . crux-delete-file-and-buffer)
   ("s-k" . crux-kill-whole-line)
   ("\e\ed" . crux-duplicate-current-line-or-region)
   ("C-x 4 t" . crux-transpose-windows)))

;; M-w C-w M-; works on single line
(use-package whole-line-or-region
  :ensure t
  :init
  (whole-line-or-region-global-mode))

(setq next-line-add-newlines t)

;; used in advice
(defun save-current-buffer-if-modified (&rest args)
  (when (and buffer-file-name (buffer-modified-p))
    (save-buffer)))

(defun print-to-scratch (string)
  (save-excursion
   (set-buffer "*scratch*")
   (insert (format "%s" string))))

(setq-default with-editor-emacsclient-executable "/usr/local/bin/emacsclient")

(provide 'global-module)
