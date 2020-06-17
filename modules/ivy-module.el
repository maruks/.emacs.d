;; ivy-module

(require 'package-module)

(package-require 'counsel)
(package-require 'flx)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))

(ivy-mode 1)

(provide 'ivy-module)
