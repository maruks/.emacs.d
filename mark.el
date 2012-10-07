;; from http://www.masteringemacs.org/articles/2010/12/22/fixing-mark-commands-transient-mark-mode/

(provide 'mark)

(defun push-mark-no-activate ()
  "Pushes point to mark-ring and does not activate the region
   Equivalent to [set-mark-command] when [transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(global-set-key (kbd "C-`") 'push-mark-no-activate)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the mark-ring order.
   This is the same as using [set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))

(global-set-key (kbd "M-`") 'jump-to-mark)

(defun exchange-point-and-mark-no-activate ()
  "Identical to [exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))

  (define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)
