;; gerbil-module

(use-package gerbil
  :when (getenv "GERBIL_HOME")
  :ensure nil
  :defer t
  :mode (("\\.ss\\'"  . gerbil-mode)
         ("\\.pkg\\'" . gerbil-mode))
  :bind (:map comint-mode-map
              (("C-S-n" . comint-next-input)
               ("C-S-p" . comint-previous-input)
               ("C-l"   . clear-comint-buffer)))
  :init
  (setf gambit (getenv "GAMBIT_HOME"))
  (setf gerbil (getenv "GERBIL_HOME"))
  (autoload 'gerbil-mode "~/.emacs.d/vendor/gerbil/gerbil.el" "Gerbil editing mode." t)
  :hook
  ((inferior-scheme-mode-hook . gambit-inferior-mode))
  :config
  (require 'gambit "~/.emacs.d/vendor/gerbil/gambit.el")
  (setf scheme-program-name (concat gerbil "/bin/gxi"))

  ;; (let ((tags (locate-dominating-file default-directory "TAGS")))
  ;;   (when tags (visit-tags-table tags)))

  (visit-tags-table (concat gerbil "/share/gerbil/TAGS"))

  (when (require 'smartparens nil 'nil-on-error)
    (sp-pair "'" nil :actions :rem)
    (sp-pair "`" nil :actions :rem))

  (defun clear-comint-buffer ()
    (interactive)
    (with-current-buffer "*scheme*"
      (let ((comint-buffer-maximum-size 0))
        (comint-truncate-buffer)))))

(provide 'gerbil-module)
