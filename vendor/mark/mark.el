;; from http://www.masteringemacs.org/articles/2010/12/22/fixing-mark-commands-transient-mark-mode/

(provide 'mark)

;; C-`      Pushes point to mark-ring and does not activate the region
;; M-`      Jumps to the local mark, respecting the mark-ring order.
;; C-x C-x  Identical to [exchange-point-and-mark]

(defun push-mark-no-activate ()
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(global-set-key (kbd "C-`") 'push-mark-no-activate)

(defun jump-to-mark ()
  (interactive)
  (set-mark-command 1))

(global-set-key (kbd "M-`") 'jump-to-mark)

(defun exchange-point-and-mark-no-activate ()
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))

(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)
