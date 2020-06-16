;; elixir-module

(require 'package-module)

(package-require 'alchemist)
(package-require 'flycheck-credo)

(defun alchemist-iex-reload (&optional arg)
  (interactive "P")
  (when (buffer-live-p alchemist-iex-buffer)
    (kill-process (get-buffer-process alchemist-iex-buffer))
    (sleep-for 1)
    (if arg
	(call-interactively 'alchemist-iex-project-run)
        (call-interactively 'alchemist-iex-run))))

(eval-after-load 'elixir-mode
  '(progn
     (define-key elixir-mode-map (kbd "C-c a i t") 'alchemist-iex-reload)
     (define-key elixir-mode-map (kbd "<f5>") 'alchemist-iex-compile-this-buffer)
     (define-key elixir-mode-map [?\s-c]      'alchemist-iex-compile-this-buffer)
     (advice-add 'alchemist-iex-compile-this-buffer :before #'save-current-buffer-if-modified)))

(add-hook 'elixir-mode-hook
	  (lambda ()
	    (flycheck-mode)
	    (alchemist-mode)
	    (company-mode)))

(eval-after-load 'flycheck
  (lambda ()
    (flycheck-credo-setup)
 ))

(provide 'elixir-module)
