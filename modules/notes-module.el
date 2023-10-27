;; notes-module

(require 'package-module)

(use-package denote
  :hook (dired-mode . denote-dired-mode)
  :config
  (setq denote-directory (expand-file-name "~/.notes"))
  (setq denote-known-keywords '("emacs" "clojure"))
  (setq denote-file-type nil))

(use-package consult-notes
  :config
  (setq consult-notes-file-dir-sources
	`(("Denote Notes" ?d ,(expand-file-name "~/.notes"))
          ("Books" ?b "~/Books/"))))

(use-package denote-menu
  :bind (("s-4" . denote-menu-list-notes))
  :config
  (setq denote-directory (expand-file-name "~/.notes")))

(provide 'notes-module)
