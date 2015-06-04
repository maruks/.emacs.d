;; themes-module

(require 'package-module)

(package-require 'zenburn-theme)
(package-require 'solarized-theme)

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

(provide 'themes-module)
