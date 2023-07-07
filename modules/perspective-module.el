;; perspective-module

(require 'package-module)

(use-package perspective
  :ensure t
  :bind
  (("s-i" . persp-ibuffer))
  :custom
  (persp-mode-prefix-key (kbd "s-p"))
  (persp-state-default-file "~/otm")
  :init
  (persp-mode)
  (consult-customize consult--source-buffer :hidden t :default nil)
  (add-to-list 'consult-buffer-sources persp-consult-source))

(provide 'perspective-module)
