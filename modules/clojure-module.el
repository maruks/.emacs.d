;; clojure-module

(require 'package-module)

(use-package flycheck-clj-kondo
  :ensure t)

(defun eldoc-hack ()
  (setq eldoc-documentation-strategy 'eldoc-documentation-default)
  (eldoc-mode 1))

(use-package clojure-mode
  :mode ("\\.clj\\'" . clojure-mode)
  :bind (("C-c ji" . cider-jack-in)
	 ("C-c js" . cider-jack-in-clj&cljs)
	 :map clojure-mode-map
	 ("s-c" . cider-load-buffer)
	 ("<f10>" . cider-load-buffer)
	 ("<f11>" . cider-jack-in)
	 ("C-c C-a" . align-cljlet)
	 :map cider-mode-map
	 ("C-h s-f" . clojure-essential-ref-nov)
	 :map cider-repl-mode-map
	 ("C-h s-f" . clojure-essential-ref-nov))

  :diminish (which-key-mode)

  :hook ((cider-repl-mode . subword-mode)
	 (cider-repl-mode . company-mode)
	 (cider-mode . company-mode)
	 (clojure-mode . (lambda () (yas-minor-mode-on)))
	 (clojure-mode . flycheck-mode)
	 (cider-mode . eldoc-hack))

  :custom

  (nrepl-hide-special-buffers t)
  (cider-repl-display-in-current-window t)
  (cider-show-error-buffer 'except-in-repl)
  (cider-prompt-for-symbol nil)

  (cider-redirect-server-output-to-repl nil)

  ;; (cider-inject-dependencies-at-jack-in nil)
  ;; (cider-repl-pop-to-buffer-on-connect nil)

  :config

  (use-package clojure-mode-extra-font-locking)
  (use-package cider)
  (use-package clj-refactor)
  (use-package align-cljlet)
  (use-package clojure-essential-ref-nov)

  (require 'flycheck-clj-kondo)

  (advice-add 'cider-load-buffer :before #'save-current-buffer-if-modified)

  (clj-refactor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c C-r")

  (setq clojure-essential-ref-nov-epub-path "~/Books/Clojure_The_Essential_Reference_v31.epub")

  (bind-clojure-snippets clojure-mode-map)

  ;; (setq cljr-eagerly-build-asts-on-startup nil)
  ;; (setq cljr-warn-on-eval t)
  ;; (setq cljr--debug-mode t)

  )



(provide 'clojure-module)
