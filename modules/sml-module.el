;; sml-module

(require 'package-module)

(package-require 'sml-mode)

(defun save-and-load-file (arg)
  (interactive "P")
  (save-buffer)
  (sml-prog-proc-load-file (buffer-file-name) (not arg)))

(eval-after-load 'sml-mode
  '(progn  
     (define-key sml-mode-map (kbd "<f5>") 'save-and-load-file)))

(provide 'sml-module)
