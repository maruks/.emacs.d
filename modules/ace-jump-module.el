;; ace-jump-module

(require 'package-module)

;; ace jump mode
;; "C-c s-j" => ace-jump-char-mode           Enter a char for query, select the highlight key to move to.
;;  M-x ace-jump-line-mode                   Each non-empty line will be marked, select the highlight key to move to.
;; "M-`"                                     Jump back

(use-package ace-jump-mode
	     :bind (("s-j" . ace-jump-mode)
		    ("C-c s-j" . ace-jump-char-mode))
	     :hook (ace-jump-mode-before-jump-hook . (lambda () (push-mark (point) t))))

(provide 'ace-jump-module)
