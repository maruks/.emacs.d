;; clojure-module

(require 'package-module)

(package-require 'clojure-mode)
(package-require 'clojure-mode-extra-font-locking)
(package-require 'cider)
(package-require 'clj-refactor)
(package-require 'align-cljlet)

(require 'clojure-mode)
(require 'clj-refactor)

(defun clj-insert-fn ()
  (interactive)
  (insert "(fn [])")
  (backward-char 2))

;; (defun stop-clj-process (arg)
;;   (interactive "P")
;;   (cider-interactive-eval "(System/exit 0)"))

(eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map [?\s-c] 'cider-load-buffer)
     (define-key clojure-mode-map (kbd "<f10>") 'cider-load-buffer)
     (define-key clojure-mode-map (kbd "<f11>") 'cider-jack-in)
     (define-key clojure-mode-map (kbd "\e\er") 'cider-switch-to-repl-buffer)
     (define-key clojure-mode-map (kbd "\e\ef") 'clj-insert-fn)
     (define-key clojure-mode-map (kbd "C-c C-a") 'align-cljlet)
     (advice-add 'cider-load-buffer :before #'save-current-buffer-if-modified)))

;; clj-refactor
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (clj-refactor-mode 1)
	    (cljr-add-keybindings-with-prefix "C-c C-r")))

;; cider
(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-repl-mode-hook #'subword-mode)

(setq nrepl-hide-special-buffers t)
;(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-repl-display-in-current-window t)
(setq cider-show-error-buffer 'except-in-repl)
(setq cider-prompt-for-symbol nil)

;; company mode
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)

(global-set-key (kbd "\e\es") 'cider-jack-in-clj&cljs)
(global-set-key (kbd "C-c ji") 'cider-jack-in)
(global-set-key (kbd "C-c js") 'cider-jack-in-clj&cljs)

;; (setq cider-inject-dependencies-at-jack-in nil)

(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")

(setq cider-redirect-server-output-to-repl nil)

;; (setq cljr-eagerly-build-asts-on-startup nil)
;; (setq cljr-warn-on-eval t)
;; (setq cljr--debug-mode t)

(provide 'clojure-module)
