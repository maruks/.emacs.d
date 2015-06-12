;; global-module

(require 'package-module)

(package-require 'ace-jump-mode)
(package-require 'projectile)
(package-require 'perspective)

(package-require 'exec-path-from-shell)
(package-require 'company)
(package-require 'org)
(package-require 'ag)

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
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".clj" ".js" ".java" ".html" ".xml" ".sh" ".el" ".erl"))

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
;; "C-c SPC" => ace-jump-word-mode           Enter first char of a word, select the highlight key to move to.
;; "C-u C-c SPC" => ace-jump-char-mode       Enter a char for query, select the highlight key to move to.
;; "C-u C-u C-c SPC" => ace-jump-line-mode   Each non-empty line will be marked, select the highlight key to move to.
;; "M-`"                                     Jump back

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(add-hook 'ace-jump-mode-before-jump-hook
          (lambda () (push-mark (point) t)))

;; M-x re-builder
(require 're-builder)
(setq reb-re-syntax 'string)

;; exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; projectile
(require 'projectile)
(projectile-global-mode)

(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)

;; global keys

(global-set-key (kbd "\e\eg") 'goto-line)

(global-set-key (kbd "C-c tf") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-c tm") 'toggle-frame-maximized)

(global-set-key [C-prior] 'previous-buffer)
(global-set-key [C-next] 'next-buffer)

;; xah-find-text
;; xah-find-text-regex
;; xah-find-count
;; xah-find-replace-text
;; xah-find-replace-text-regex
(package-require 'xah-find)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'global-module)
