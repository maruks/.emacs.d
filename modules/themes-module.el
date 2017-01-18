;; -*- lexical-binding: t -*-
;; themes-module

(require 'package-module)

(package-require 'sublime-themes)

(package-require 'bliss-theme)
(package-require 'darcula-theme)
(package-require 'flatland-theme)
(package-require 'hamburg-theme)
(package-require 'heroku-theme)
(package-require 'solarized-theme)
(package-require 'smyx-theme)
(package-require 'reykjavik-theme)
(package-require 'foggy-night-theme)
(package-require 'yoshi-theme)
(package-require 'zenburn-theme)

;; color themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(defvar theme-current-theme nil)
(defvar theme-key-prefix "C-c C-t")
(defvar theme-key-disable "C-d")
(defvar theme-set-keys #s(hash-table size 30 data (br brin
						   bl bliss
						   da darcula
						   db deeper-blue
						   do dorsey
						   dr dream
						   er erosiond
						   fn foggy-night
						   fo fogus
						   fl flatland
						   gh graham
						   gr granger
						   ha hamburg
						   he heroku
						   hi hickey
						   ju junio
						   ne tomorrow-night-eighties
						   ni tomorrow-night
						   nb tomorrow-night-bright
						   mi misterioso
						   od odersky
						   re reykjavik
						   sd solarized-dark
						   sp spolsky
						   sm smyx
						   td tango-dark
						   yo yoshi
						   ze zenburn
						   wi wilson
						   wo wombat
						   ;; -------------------------   bright
						   di dichromacy
						   gi github
						   mc mccarthy
						   sl solarized-light
						   ra radiance
						   ri ritchie
						   ta tango
						   to tomorrow
						   vi vim-colors
						   le leuven
						   il idris-leuven-theme)))

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
