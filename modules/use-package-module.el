;; use-package-module

(require 'package-module)

(package-require 'diminish)

(add-to-list 'load-path "~/.emacs.d/vendor/use-package")

(require 'use-package)
(require 'diminish)

(setq use-package-always-ensure t)

(provide 'use-package-module)
