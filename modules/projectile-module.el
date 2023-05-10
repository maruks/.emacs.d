;; projectile-module

(require 'package-module)

(package-require 'projectile)

;; projectile
(use-package projectile
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :bind (:map projectile-mode-map
	      ;; ("s-a" . projectile-ag)
	      ;; ("s-d" . projectile-find-dir)
	      ;; ("s-p" . projectile-switch-project)
	      ;; ("s-b" . projectile-switch-to-buffer)
	      ;; ("s-f" . projectile-find-file)
	      ("\e\et" . projectile-find-implementation-or-test-other-window)
	      ("s-g r" . projectile-grep)
	      ("s-r" . projectile-replace))
  :init
  (setq projectile-create-missing-test-files t)
  (setq ag-reuse-buffers 't)
  (setq projectile-completion-system 'default)
  (projectile-global-mode))

(provide 'projectile-module)
