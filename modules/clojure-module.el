;; clojure-module

(require 'package-module)

(package-require 'clojure-mode)
(package-require 'cider)
(package-require 'clj-refactor)
(package-require 'align-cljlet)

(require 'clojure-mode)
(require 'clj-refactor)

(defun compile-buffer (arg)
  (interactive "P")
  (save-buffer)
  (cider-load-buffer)
  (when arg
    (cider-switch-to-relevant-repl-buffer nil)))

; speclj runner
(defun compile-run-tests (arg)
  (interactive "P")
  (save-buffer)
  (cider-load-buffer)
  (cider-interactive-eval "(speclj.core/run-specs)")
  (when arg
    (cider-switch-to-relevant-repl-buffer nil)))

(defun clj-insert-fn ()
  (interactive)
  (insert "(fn [])")
  (backward-char 2))

(eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map (kbd "<f5>") 'compile-buffer)
     (define-key clojure-mode-map (kbd "<f6>") 'compile-run-tests)
     (define-key clojure-mode-map (kbd "\e\er") 'cider-switch-to-relevant-repl-buffer)
     (define-key clojure-mode-map (kbd "\e\ef") 'clj-insert-fn)))

;; clj-refactor
(add-hook 'clojure-mode-hook
          (lambda ()
	    (clj-refactor-mode 1)
	    (cljr-add-keybindings-with-prefix "C-c C-a")))

;; cider
(add-hook 'cider-mode-hook #'eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-show-error-buffer 'except-in-repl)
(add-hook 'cider-repl-mode-hook #'subword-mode)

;; company mode
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

(global-set-key (kbd "\e\ec") 'cider-jack-in)
(global-set-key (kbd "C-c ji") 'cider-jack-in)

(provide 'clojure-module)
