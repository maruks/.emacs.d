;; smart-mode-line-module

(require 'package-module)

(add-to-list 'load-path "~/.emacs.d/vendor/mode-line")
(require 'mode-line)

(setq prev-mode-line nil)

(defun change-mode-line ()
  (interactive)
  (if prev-mode-line
      (progn
	(setq-default mode-line-format prev-mode-line)
	(setq prev-mode-line nil))
      (progn
        (setq prev-mode-line mode-line-format)
        (setq-default mode-line-format (better-mode-line)))))

(change-mode-line)

(provide 'smart-mode-line-module)
