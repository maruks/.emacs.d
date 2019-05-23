;; mituharu-module

;; https://bitbucket.org/mituharu/emacs-mac
;; brew install autoconf automake
;; brew install texinfo
;; export PATH="/usr/local/opt/texinfo/bin:$PATH"
;; ./autogen.sh
;; ./configure --enable-mac-app
;; make && make install

(require 'package-module)

(setq mac-option-modifier 'meta)

(setq mac-command-modifier 'super)

(mac-auto-operator-composition-mode)

(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))

  (defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))

  (add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)

  (when (display-graphic-p)
    (ns-raise-emacs)))

(provide 'mituharu-module)
