;; git-module

(require 'package-module)

;; magit
(package-require 'magit)
(package-require 'git-timemachine)
(package-require 'gitconfig-mode)

(global-set-key (kbd "\e\em") 'magit-status)
(global-set-key (kbd "<f8>") 'magit-status)

(global-set-key (kbd "M-g t") 'git-timemachine-toggle)
(global-set-key (kbd "\e\et") 'git-timemachine-toggle)
(global-set-key (kbd "\e\eb") 'magit-blame)

(provide 'git-module)
