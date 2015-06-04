;; fundamental-module

(require 'package-module)

;; duplicate current line
(defun duplicate-current-line (&optional n)
  "duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((nb (or n 1))
          (current-line (thing-at-point 'line)))
      (when (or (= 1 (forward-line 1)) (eq (point) (point-max)))
        (insert "\n"))
      (while (> n 0)
        (insert current-line)
        (decf n)))))

;; global keys
(global-set-key (kbd "\e\ed") 'duplicate-current-line)

(provide 'fundamental-module)
