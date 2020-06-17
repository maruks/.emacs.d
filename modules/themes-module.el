;; -*- lexical-binding: t -*-
;; themes-module

(require 'package-module)

(package-require 'sublime-themes)
(package-require 'color-theme-sanityinc-tomorrow)
(package-require 'atom-one-dark-theme)
(package-require 'darcula-theme)
(package-require 'dracula-theme)
(package-require 'flatland-theme)
(package-require 'spacemacs-theme)
(package-require 'apropospriate-theme)
(package-require 'heroku-theme)
(package-require 'solarized-theme)
(package-require 'night-owl-theme)
(package-require 'smyx-theme)
(package-require 'reykjavik-theme)
(package-require 'planet-theme)
(package-require 'inkpot-theme)
(package-require 'zenburn-theme)
(package-require 'ample-theme)
(package-require 'doom-themes)

;; moe
(add-to-list 'load-path "~/.emacs.d/vendor/moe-theme")
(require 'moe-theme)

;; color themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(defvar theme-key-prefix "s-3")
(defvar theme-key-disable "C-d")
(defvar theme-set-keys #s(hash-table size 30 data (af ample-flat    ;; *
						   ap apropospriate-dark
						   at atom-one-dark ;; low contrast
						   br brin
						   da darcula
						   dc dracula   ;; high contrast, https://draculatheme.com
						   do doom-one  ;; *
						   dv doom-vibrant ;; low contrast
						   dr dream
						   er erosiond
						   fo fogus
						   fl flatland  ;; *
						   gh graham
						   he heroku
						   hi hickey
						   ju junio
						   ip inkpot
						   mi misterioso
						   md moe-dark ;; *
						   no night-owl
						   od odersky
						   pl planet  ;; nice
						   re reykjavik ;; *
						   sd solarized-dark
						   se sanityinc-tomorrow-eighties ;; nice
						   sp spacemacs-dark  ;; *
						   sm smyx
						   td tango-dark ;; *
						   te tomorrow-night-eighties ;; *
						   tn tomorrow-night
						   tb tomorrow-night-bright
						   ze zenburn ;; nice
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
  (theme-disable-current)
  (load-theme theme t)
  (message "theme loaded: %s" (symbol-name theme)))

(defun theme-disable-current ()
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

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
