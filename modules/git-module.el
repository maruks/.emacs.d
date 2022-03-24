;; git-module

(require 'package-module)

;; magit

(use-package magit
  :commands (magit-status magit-blame)
  :bind
  (("s-m" . magit-status)
   ("\e\eb" . magit-blame)))

(use-package git-timemachine
  :bind
  (("s-t" . git-timemachine-toggle)))

(provide 'git-module)
