;; erlang-module

(require 'package-module)

(defun load-erlang ()
  (add-to-list 'load-path "~/.emacs.d/vendor/erlang")
  (let ((erlang-root (or (getenv "_KERL_ACTIVE_DIR") "/usr/local/lib/erlang")))
    (setq erlang-root-dir erlang-root)    
    (setq exec-path (cons (concat erlang-root-dir "/bin") exec-path)))
  (require 'erlang-start)
  (require 'erlang-eunit)
  (setq inferior-erlang-machine-options '("-sname" "emacs")))

(load-erlang)

(defun compile-erlang-buffer (arg)
  (interactive "P")
  (save-buffer)
  (erlang-compile)
  (when arg 
    (switch-to-buffer-other-window "*erlang*")))

(defun compile-erlang-buffer-and-test (arg)
  (interactive "P")
  (save-buffer)
  (erlang-eunit-compile-and-run-module-tests)
  (when arg 
    (switch-to-buffer-other-window "*erlang*")))

(defun erlang-paredit ()
  (progn
    (define-key erlang-mode-map [?\(] 'paredit-open-parenthesis)
    (define-key erlang-mode-map [?\[] 'paredit-open-square)
    (define-key erlang-mode-map [?\{] 'paredit-open-curly)
    (define-key erlang-mode-map [?\)] 'paredit-close-parenthesis)
    (define-key erlang-mode-map [?\}] 'paredit-close-curly)
    (define-key erlang-mode-map [?\]] 'paredit-close-square)
    (set (make-local-variable 'paredit-space-for-delimiter-predicates) '((lambda (endp delimiter) nil)))))

(add-hook 'erlang-mode-hook
	  (lambda ()
	    (define-key erlang-mode-map (kbd "<f5>") 'compile-erlang-buffer)
	    (define-key erlang-mode-map (kbd "<f6>") 'compile-erlang-buffer-and-test)	    
	    (enable-paredit)
	    (erlang-paredit)))

(eval-after-load 'erlang
  '(message "Erlang root is %s." erlang-root-dir))

;; distel

(defun load-distel ()
  (interactive)
  (let ((location "~/.emacs.d/vendor/distel/elisp"))
    (if (file-exists-p location)
	(do-load-distel)   
      (message "distel not installed in %s" location))))

(defun do-load-distel (location)
  (add-to-list 'load-path location)
  (require 'distel)
  (distel-setup)

  (defvar inferior-erlang-prompt-timeout t)
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  (setq erl-nodename-cache
	(make-symbol
	 (concat
	  "emacs@"
	  (car (split-string (shell-command-to-string "hostname")))))))

(provide 'erlang-module)
