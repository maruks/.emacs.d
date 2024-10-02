;; -*- lexical-binding: t -*-
;; themes-module

(require 'package-module)

(package-require 'sublime-themes)
(package-require 'color-theme-sanityinc-tomorrow)
(package-require 'atom-one-dark-theme)
(package-require 'darcula-theme)
(package-require 'dracula-theme)
(package-require 'clues-theme)
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
(package-require 'modus-themes)
(package-require 'ef-themes)
(package-require 'moe-theme)
(package-require 'catppuccin-theme)

;; themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(defvar theme-key-prefix "s-1")
(defvar theme-key-disable "C-d")
(defvar theme-set-keys #s(hash-table size 30 data (ac doom-acario-dark
						   af ample-flat    ;; *
						   ap apropospriate-dark
						   at atom-one-dark ;; low contrast

						   br brin
						   bl doom-bluloco-dark

						   ca catppuccin
						   ch doom-challenger-deep ;; high contrast
						   cl clues ;; high contrast blue

						   da doom-ayu-mirage
						   db doom-badger
						   dc doom-city-lights
						   dd doom-dark+
						   de doom-ephemeral
						   df doom-feather-dark
						   dg doom-gruvbox
						   dh doom-horizon
						   di doom-Iosvkem
						   dj darcula
						   dk doom-ayu-dark
						   dl doom-lantern
						   dm doom-moonlight  ;; nice
						   dn doom-nord  ;; nice
						   do doom-one  ;; nice
                                                   dp doom-palenight ;; high contrast
						   dq doom-dracula
						   dr doom-rouge
						   ds doom-sourcerer
						   dt doom-tokyo-night ;; !
						   du doom-nord-aurora
						   dv doom-vibrant ;; low contrast
						   dw doom-wilmersdorf  ;; nice
						   dx doom-xcode
						   dz doom-zenburn ;; low contrast

						   er erosiond

						   fo fogus
						   fl flatland  ;; *

						   gh graham

						   he doom-henna
						   hi hickey
						   ho doom-homage-black

						   ip inkpot
						   ir doom-ir-black

						   ju junio

						   ma doom-material
						   mc doom-monokai-classic
						   md moe-dark
						   mi misterioso
                                                   mm doom-monokai-machine
						   mo doom-molokai
						   mp doom-monokai-pro
                                                   mr doom-monokai-ristretto
                                                   ms doom-monokai-spectrum
						   mv modus-vivendi-tinted

						   no night-owl

						   oc doom-oceanic-next
						   od odersky
						   op doom-opera
						   oh doom-old-hope
						   ok doom-oksolar-dark  ;; !

						   pe doom-peacock
						   pi doom-pine
						   pl planet  ;; nice

						   re reykjavik ;; *

						   sd solarized-dark
						   sg doom-spacegrey
						   se sanityinc-tomorrow-eighties ;; nice
						   sm smyx
						   sn doom-snazzy
						   so doom-solarized-dark-high-contrast
						   sp spacemacs-dark  ;; *

						   tb tomorrow-night-bright
						   td tango-dark ;; *
						   te tomorrow-night-eighties ;; *
						   to doom-tomorrow-night
						   tn tomorrow-night

						   wo wombat

						   ze zenburn ;; nice
						   ;; -------------------------   light
						   dy dichromacy
						   gi github
						   mh mccarthy
						   mt modus-operandi-tinted
						   sl solarized-light
						   ra radiance
						   ri ritchie
						   ta tango
						   tm tomorrow
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
	       (lambda () (interactive) (theme-enable v))))
	    theme-set-keys))

(defun theme-load (name)
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar 'symbol-name (custom-available-themes))))))
  (theme-enable name))

(global-set-key (kbd "s-2") 'theme-load)

(defun theme-load-default ()
  (let ((default-theme (getenv "EMACS_DEFAULT_THEME")))
    (when default-theme
      (theme-enable (intern default-theme)))))

;;  init

(theme-init-keys)
(theme-load-default)

;; hook
(defvar after-enable-theme-hook nil
   "Normal hook run after enabling a theme.")

(defun run-after-enable-theme-hook (&rest args)
  "Run `after-enable-theme-hook'."
  (run-hook-with-args 'after-enable-theme-hook (car args)))

(advice-add 'enable-theme :after #'run-after-enable-theme-hook)

(defun amend-font-faces (theme)
  (let* ((name (symbol-name theme))
	 (ef (string-prefix-p "ef-" name)))
    (if ef
	(progn
	  ;; disable bold and italic
	    (set-face-attribute 'bold nil :weight 'normal)
	    (set-face-attribute 'italic nil :slant 'normal))
      (progn
	  (set-face-attribute 'bold nil :weight 'bold)
	  (set-face-attribute 'italic nil :slant 'italic)))))

(add-hook 'after-enable-theme-hook 'amend-font-faces)

(provide 'themes-module)
