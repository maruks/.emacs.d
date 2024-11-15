;; appearance-module

(require 'package-module)

(menu-bar-mode -1)

(setopt tooltip-mode nil) ;; https://github.com/clojure-emacs/cider/issues/3748

(when (and window-system (boundp 'tool-bar-mode))
  (tool-bar-mode -1))

(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(show-paren-mode 1)

;; https://andreyor.st/posts/2020-07-21-programming-ligatures-in-emacs/
;; JetBrains Mono
(defun set-composition-char-table ()
    (dolist (char/ligature-re
             `((?-  . ,(rx (or (or "-->" "-<<" "->>" "-|" "-~" "-<" "->") (+ "-"))))
               (?/  . ,(rx (or (or "/==" "/=" "/>" "/**" "/*") (+ "/"))))
               (?*  . ,(rx (or (or "*>" "*/") (+ "*"))))
               (?<  . ,(rx (or (or "<<=" "<<-" "<|||" "<==>" "<!--" "<=>" "<||" "<|>" "<-<"
				   "<==" "<=<" "<-|" "<~>" "<=|" "<~~" "<$>" "<+>" "</>"
				   "<*>" "<->" "<=" "<|" "<:" "<>"  "<$" "<-" "<~" "<+"
				   "</" "<*")
                               (+ "<"))))
               (?:  . ,(rx (or (or ":?>" "::=" ":>" ":<" ":?" ":=") (+ ":"))))
               (?=  . ,(rx (or (or "=>>" "==>" "=/=" "=!=" "=>" "=:=") (+ "="))))
               (?!  . ,(rx (or (or "!==" "!=") (+ "!"))))
               (?>  . ,(rx (or (or ">>-" ">>=" ">=>" ">]" ">:" ">-" ">=") (+ ">"))))
               (?&  . ,(rx (+ "&")))
               (?|  . ,(rx (or (or "|->" "|||>" "||>" "|=>" "||-" "||=" "|-" "|>"
				   "|]" "|}" "|=")
                               (+ "|"))))
               (?.  . ,(rx (or (or ".?" ".=" ".-" "..<") (+ "."))))
               (?+  . ,(rx (or "+>" (+ "+"))))
               (?\[ . ,(rx (or "[<" "[|")))
               (?\{ . ,(rx "{|"))
               (?\? . ,(rx (or (or "?." "?=" "?:") (+ "?"))))
               (?#  . ,(rx (or (or "#_(" "#[" "#{" "#=" "#!" "#:" "#_" "#?" "#(")
                               (+ "#"))))
               (?\; . ,(rx (+ ";")))
               (?_  . ,(rx (or "_|_" "__")))
               (?~  . ,(rx (or "~~>" "~~" "~>" "~-" "~@")))
               (?$  . ,(rx "$>"))
               (?^  . ,(rx "^="))
               (?\] . ,(rx "]#"))))
      (let ((char (car char/ligature-re))
            (ligature-re (cdr char/ligature-re)))
	(set-char-table-range composition-function-table char
                              `([,ligature-re 0 font-shape-gstring])))))

(use-package emacs
  :hook (prog-mode . auto-composition-mode)
  :init (global-auto-composition-mode -1)
  :config (set-composition-char-table))

(provide 'appearance-module)
