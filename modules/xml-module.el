;; xml-module

(require 'package-module)

(defun xml-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (point-min) (point-max) "xmllint --format -" (buffer-name) t)))

(provide 'xml-module)
