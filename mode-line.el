;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(setq-default mode-line-format
	      (list "%e"
	       ;; the buffer name; the file name as a tool tip
	       '(:eval (propertize "  %b " 'face 'font-lock-type-face
				   'help-echo (buffer-file-name)))

	       ;; the current major mode for the buffer.
	       "["

	       '(:eval (propertize "%m" 'face 'font-lock-string-face
				   'help-echo buffer-file-coding-system))
	       "] "

	       "[" ;; insert vs overwrite mode, input-method in a tooltip
	       '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
				   'face 'font-lock-preprocessor-face
				   'help-echo (concat "Buffer is in "
						      (if overwrite-mode "overwrite" "insert") " mode")))

	       ;; was this buffer modified since the last save?
	       '(:eval (when (buffer-modified-p)
			 (concat ","  (propertize "Mod"
						  'face 'font-lock-warning-face
						  'help-echo "Buffer has been modified"))))

	       ;; is this buffer read-only?
	       '(:eval (when buffer-read-only
			 (concat ","  (propertize "RO"
						  'face 'font-lock-type-face
						  'help-echo "Buffer is read-only"))))  
	       "] "

	       ;; line and column
	       (propertize "(%03l," 'face 'font-lock-comment-face)
	       (propertize "%03c) " 'face 'font-lock-comment-face) 

	       ;; relative position, size of file
	       (propertize "[%p/%I]" 'face 'font-lock-comment-face) ;; % above top

	       '(:propertize
		  (:eval (let ((backend (symbol-name (vc-backend (buffer-file-name)))))
			   (concat " " (substring vc-mode (+ (length backend) 2)))))
		  face font-lock-variable-name-face)

	       '(:propertize
		 (:eval (when (ignore-errors (projectile-project-root))
			  (concat " " (projectile-project-name))))
		 face font-lock-constant-face)	    
   
	       ;;" "
	       ;; i don't want to see minor-modes; but if you want, uncomment this:
	       ;; minor-mode-alist  ;; list of minor modes
	       ;;"%-" ;; fill with '-'
	       ))
