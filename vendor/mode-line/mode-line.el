
(provide 'mode-line)

(defun mode-line-1 ()
  (list "%e"
	'(:eval (propertize "  %b " 'face 'font-lock-type-face
			    'help-echo (buffer-file-name)))
	"["
	'(:eval (propertize "%m" 'face 'font-lock-string-face
			    'help-echo buffer-file-coding-system))
	"] "
	"["
	'(:eval (propertize (if overwrite-mode "Ovr" "Ins")
			    'face 'font-lock-preprocessor-face
			    'help-echo (concat "Buffer is in "
					       (if overwrite-mode "overwrite" "insert") " mode")))
	'(:eval (when (buffer-modified-p)
		  (concat ","  (propertize "Mod"
					   'face 'font-lock-warning-face
					   'help-echo "Buffer has been modified"))))
	'(:eval (when buffer-read-only
		  (concat ","  (propertize "RO"
					   'face 'font-lock-type-face
					   'help-echo "Buffer is read-only"))))
	"] "
	(propertize "(%03l," 'face 'font-lock-comment-face)
	(propertize "%03c) " 'face 'font-lock-comment-face)
	(propertize "[%p/%I]" 'face 'font-lock-comment-face) ;; % above top
	'(:propertize
	  (:eval (let ((backend (symbol-name (vc-backend (buffer-file-name)))))
		   (concat " " (substring vc-mode (+ (length backend) 2)))))
	  face font-lock-variable-name-face)
	'(:propertize
	  (:eval (when (ignore-errors (projectile-project-root))
		   (concat " " (projectile-project-name))))
	  face font-lock-constant-face)))

(defun mode-line-2 ()
  (list "%e"
	'(:eval (propertize "  %b " 'help-echo (buffer-file-name)))
	"["
	'(:eval (propertize "%m" 'help-echo buffer-file-coding-system))
	"] "
	"["
	'(:eval (propertize (if overwrite-mode "Ovr" "Ins")
			    'help-echo (concat "Buffer is in "
					       (if overwrite-mode "overwrite" "insert") " mode")))
	'(:eval (when (buffer-modified-p)
		  (concat ","  (propertize "Mod" 'help-echo "Buffer has been modified"))))
	'(:eval (when buffer-read-only
		  (concat ","  (propertize "RO" 'help-echo "Buffer is read-only"))))
	"] "
	(propertize "(%03l,")
	(propertize "%03c) ")
	(propertize "[%p/%I]") ;; % above top
	'(:propertize
	  (:eval (let ((backend (symbol-name (vc-backend (buffer-file-name)))))
		   (concat " " (substring vc-mode (+ (length backend) 2))))))
	'(:propertize
	  (:eval (when (ignore-errors (projectile-project-root))
		   (concat " " (projectile-project-name)))))))
