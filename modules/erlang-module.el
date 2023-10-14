;; erlang-module

(require 'package-module)

(defun start-shell-in-project-root (orig-fun &rest args)
  (let ((default-directory (projectile-project-root)))
    (apply orig-fun args)))

(defun use-rebar-shell ()
  (interactive)
  (advice-add 'erlang-shell-display :around #'start-shell-in-project-root)
  (setq inferior-erlang-machine "rebar3")
  (setq inferior-erlang-machine-options '("shell" "--sname" "emacs@localhost" "--setcookie" "foo"))
  (setq inferior-erlang-shell-type nil))

(use-package erlang

  :bind (:map erlang-mode-map
	      ("s-c" . 'erlang-compile)
	      ("s-e" . 'erlang-eunit-compile-and-run-module-tests))

  :hook ((erlang-mode . eglot-ensure))

  :init
  (advice-add 'erlang-compile :before #'save-current-buffer-if-modified)
  (advice-add 'erlang-eunit-compile-and-run-module-tests :before #'save-current-buffer-if-modified))
  (use-rebar-shell)

(provide 'erlang-module)
