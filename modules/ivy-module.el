;; ivy-module

(require 'package-module)

(package-require 'counsel)
(package-require 'flx)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-use-selectable-prompt t)

(setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))

(ivy-mode 1)

(setq ivy-extra-directories ())

(define-key global-map (kbd "M-i") 'counsel-imenu)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "s-s") 'swiper-isearch)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)
(global-set-key (kbd "C-c b") 'counsel-bookmark)

(setq counsel-find-file-ignore-regexp (regexp-opt completion-ignored-extensions))

(provide 'ivy-module)
