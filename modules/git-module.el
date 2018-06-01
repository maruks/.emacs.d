;; git-module

(require 'package-module)

;; magit
(package-require 'magit)
(package-require 'git-timemachine)
(package-require 'gitconfig-mode)

(global-set-key (kbd "s-m") 'magit-status)
(global-set-key (kbd "s-t") 'git-timemachine-toggle)

(global-set-key (kbd "\e\eb") 'magit-blame)

(provide 'git-module)
