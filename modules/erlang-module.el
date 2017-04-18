;; erlang-module

(require 'package-module)

(package-require 'flycheck-dialyzer)
(package-require 'flycheck-rebar3)

(flycheck-rebar3-setup)

(defun use-rebar3-shell ()
  (interactive)
  (setq inferior-erlang-machine "rebar3")
  (setq inferior-erlang-machine-options '("shell"))
  (setq inferior-erlang-shell-type nil))

(defun load-erlang ()
  (add-to-list 'load-path "~/.emacs.d/vendor/erlang")
  (let ((erlang-root (or (getenv "_KERL_ACTIVE_DIR") "/usr/local/lib/erlang")))
    (setq erlang-root-dir erlang-root)
    (setq exec-path (cons (concat erlang-root-dir "/bin") exec-path)))
  (require 'erlang-start)
  (require 'erlang-eunit)
  (setq inferior-erlang-machine-options '("-sname" "emacs@localhost")))

;; distel

(defun load-distel ()
  (interactive)
  (let ((location "~/.emacs.d/vendor/distel/elisp"))
    (if (file-exists-p location)
	(do-load-distel location)
        (message "distel not installed in %s" location))))

(defun do-load-distel (location)
  (add-to-list 'load-path location)
  (require 'distel)
  (package-require 'company-distel)
  (distel-setup)

  (defvar inferior-erlang-prompt-timeout t)
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  (setq erl-nodename-cache
	(make-symbol
	 (concat
	  "emacs@"
	  (car (split-string (shell-command-to-string "hostname"))))))

  (add-hook 'erlang-mode-hook
	    (lambda ()
	      (setq company-backends '(company-distel))
	      (company-mode))))

(load-erlang)
(load-distel)

(defun compile-erlang-buffer (arg)
  (interactive "P")
  (save-buffer)
  (erlang-compile)
  (when arg
    (switch-to-buffer-other-window "*erlang*")))

(defun compile-erlang-buffer-and-test (arg)
  (interactive "P")
  (save-buffer)
  (erlang-eunit-compile-and-run-module-tests))

;; [C-u] C-c C-e k
;; C-c C-e c
(add-hook 'erlang-mode-hook
	  (lambda ()
	    (define-key erlang-mode-map (kbd "<f5>") 'compile-erlang-buffer)
	    (define-key erlang-mode-map [?\s-c] 'compile-erlang-buffer)
	    (define-key erlang-mode-map (kbd "<f6>") 'compile-erlang-buffer-and-test)
	    (setq flycheck-erlang-include-path (list "../include/"))
	    (setq erlang-compile-extra-opts '((i . \"../include\")))
	    (flycheck-mode)))

(eval-after-load 'erlang
  '(message "Erlang root is %s." erlang-root-dir))

(provide 'erlang-module)
