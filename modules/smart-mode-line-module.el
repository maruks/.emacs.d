;; smart-mode-line-module

(require 'package-module)

(add-to-list 'load-path "~/.emacs.d/vendor/mode-line")
(require 'mode-line)

(defvar smart-mode-lines `((default . ,mode-line-format)
			   (line-1 . ,(mode-line-1))
			   (line-2 . ,(mode-line-2))))

(defun smart-mode-line (name)
  (interactive
   (list
    (intern (completing-read "Set custom mode line: "
                             (mapcar 'car smart-mode-lines)))))
  (smart-mode-line-set name))

(defun smart-mode-line-set (name)
  (setq-default mode-line-format (cdr (assoc name smart-mode-lines))))

(defun smart-mode-line-init ()
  (let ((m (getenv "EMACS_DEFAULT_MODE_LINE")))
    (when m
      (smart-mode-line-set (intern m)))))

;; init

(smart-mode-line-init)

(provide 'smart-mode-line-module)
