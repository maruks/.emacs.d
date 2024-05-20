;; fonts-module

(require 'package-module)

(setq font (getenv "EMACS_DEFAULT_FONT"))

(when (eq system-type 'darwin)
  (setq font (or font "Menlo-15")))  ;; Source Code Pro-15

(when (eq system-type 'gnu/linux)
  (setq font (or font "DejaVu Sans Mono-10")))

(when font
  (set-frame-font font nil t)
  (add-to-list 'default-frame-alist (cons 'font font)))

(setq font-presets
      '((mono-lisa .       "MonoLisa 2:pixelsize=23:weight=regular:slant=normal:width=normal:spacing=100:scalable=true")
	(mono-lisa-light . "MonoLisa 2:pixelsize=23:weight=light:slant=normal:width=normal:spacing=100:scalable=true")
        (fira-code .       "Fira Code:pixelsize=24:weight=regular:slant=normal:width=normal:spacing=100:scalable=true")
        (fira-code-light . "Fira Code:pixelsize=24:weight=light:slant=normal:width=normal:spacing=100:scalable=true")
        (berkeley-mono .   "Berkeley Mono:pixelsize=24:weight=regular:slant=normal:width=normal:spacing=100:scalable=true")
        (jetbrains-mono .  "JetBrains Mono:pixelsize=24:weight=regular:slant=normal:width=normal:spacing=100:scalable=true")
        (jetbrains-mono-light . "JetBrains Mono:pixelsize=24:weight=light:slant=normal:width=normal:spacing=100:scalable=true")))


(defun set-f0nt (preset)
  (interactive
   (let ((completion-ignore-case  t))
     (list (completing-read "Choose: " (mapcar 'car font-presets) nil t))))
  (let ((font (cdr (assoc (intern preset) font-presets))))
    (set-frame-font font)
    (message "Selected font: `%s'" font)))

(provide 'fonts-module)
