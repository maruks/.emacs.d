;; clojure-module

(require 'package-module)

(use-package clojure-mode
  :mode ("\\.clj\\'" . clojure-mode)
  :bind (("C-c ji" . cider-jack-in)
	 ("C-c js" . cider-jack-in-clj&cljs)
	 ("\e\es" . cider-jack-in-clj&cljs)
	 :map clojure-mode-map
	 ("s-c" . cider-load-buffer)
	 ("<f10>" . cider-load-buffer)
	 ("<f11>" . cider-jack-in)
	 ("\e\er" . cider-switch-to-repl-buffer)
	 ("\e\ef" . clj-insert-fn)
	 ("C-c C-a" . align-cljlet))

  :diminish (which-key-mode)

  :hook ((cider-repl-mode . subword-mode)
	 (cider-repl-mode . company-mode)
	 (cider-mode . company-mode))

  :init

  (setq nrepl-hide-special-buffers t)
  (setq cider-repl-display-in-current-window t)
  (setq cider-show-error-buffer 'except-in-repl)
  (setq cider-prompt-for-symbol nil)

  (setq cider-redirect-server-output-to-repl nil)

  ;; (setq cider-inject-dependencies-at-jack-in nil)
  ;; (setq cider-repl-pop-to-buffer-on-connect nil)

  :config

  (use-package clojure-mode-extra-font-locking)
  (use-package cider)
  (use-package clj-refactor)
  (use-package align-cljlet)

  (advice-add 'cider-load-buffer :before #'save-current-buffer-if-modified)

  (eldoc-mode 1)

  (clj-refactor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c C-r")

  ;; (setq cljr-eagerly-build-asts-on-startup nil)
  ;; (setq cljr-warn-on-eval t)
  ;; (setq cljr--debug-mode t)

  )

(provide 'clojure-module)
