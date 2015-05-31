;; git-module

(require 'package-module)

;; magit
(package-require 'magit)

(global-set-key (kbd "\e\em") 'magit-status)
(global-set-key (kbd "<f8>") 'magit-status)

(provide 'git-module)
