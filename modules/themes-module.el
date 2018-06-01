;; -*- lexical-binding: t -*-
;; themes-module

(require 'package-module)

(package-require 'sublime-themes)

(package-require 'atom-one-dark-theme)
(package-require 'darcula-theme)
(package-require 'dracula-theme)
(package-require 'flatland-theme)
(package-require 'hamburg-theme)
(package-require 'heroku-theme)
(package-require 'solarized-theme)
(package-require 'smyx-theme)
(package-require 'reykjavik-theme)
(package-require 'yoshi-theme)
(package-require 'zenburn-theme)
(package-require 'moe-theme)
(package-require 'ample-theme)
(package-require 'doom-themes)
(package-require 'color-theme-sanityinc-tomorrow)

(require 'moe-theme) ;; !

;; color themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(defvar theme-current-theme nil)
(defvar theme-key-prefix "s-3")
(defvar theme-key-disable "C-d")
(defvar theme-set-keys #s(hash-table size 30 data (af ample-flat    ;; *
						   at atom-one-dark ;; *
						   br brin
						   da darcula
						   dc dracula   ;; https://draculatheme.com
						   do doom-one  ;; *
						   dv doom-vibrant
						   dr dream
						   er erosiond
						   fo fogus
						   fl flatland  ;; *
						   gh graham
						   he heroku
						   hi hickey
						   ju junio
						   mi misterioso
						   md moe-dark ;; *
						   od odersky
						   re reykjavik
						   sd solarized-dark
						   se sanityinc-tomorrow-eighties ;; *
						   sm smyx  ;; *
						   td tango-dark ;; *
						   te tomorrow-night-eighties ;; *
						   tn tomorrow-night
						   tb tomorrow-night-bright
						   ze zenburn
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
						   le leuven)))

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
