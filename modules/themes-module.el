;; -*- lexical-binding: t -*-
;; themes-module

(require 'package-module)

(package-require 'sublime-themes)

(package-require 'zenburn-theme)
(package-require 'solarized-theme)
(package-require 'darcula-theme)
(package-require 'bliss-theme)
(package-require 'smyx-theme)

;; color themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(defvar theme-current-theme nil)
(defvar theme-key-prefix "C-c C-t")
(defvar theme-key-disable "C-d")
(defvar theme-set-keys #s(hash-table size 30 data (br brin
						   db deeper-blue
						   do dorsey
						   dr dream
						   di dichromacy
						   er erosiond
      						   gi github
						   gr granger
						   fo fogus
						   hi hickey
						   mc mccarthy
						   ne tomorrow-night-eighties
						   ni tomorrow-night
						   nb tomorrow-night-bright
						   le leuven
						   il idris-leuven-theme
						   od odersky
   						   ra radiance
						   sd solarized-dark
						   sl solarized-light
						   ta tango
						   to tomorrow
						   vi vim-colors
						   ze zenburn
						   wo wombat)))

(defun theme-enable (theme)
  (if theme-current-theme (disable-theme theme-current-theme))
  (setq theme-current-theme theme)
  (load-theme theme t)
  (message "theme loaded: %s" (symbol-name theme)))

(defun theme-disable-current ()
  (if theme-current-theme (disable-theme theme-current-theme))
  (setq theme-current-theme nil))

(defun theme-init-keys ()
  (global-set-key
   (kbd (concat theme-key-prefix " " theme-key-disable))
   '(lambda () (interactive) (theme-disable-current)))
  (maphash  (lambda (k v)
	      (global-set-key
	       (kbd (concat theme-key-prefix " " (symbol-name k)))
	       (lambda () (interactive) (theme-enable v)))) theme-set-keys))

(defun theme-load (name)
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar 'symbol-name (custom-available-themes))))))
  (theme-enable name))

(defun theme-load-default ()
  (let ((default-theme (getenv "EMACS_DEFAULT_THEME")))
    (when default-theme
      (theme-enable (intern default-theme)))))

;;  init

(theme-init-keys)
(theme-load-default)

(provide 'themes-module)
