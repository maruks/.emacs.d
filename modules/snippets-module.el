;; snippets-module

(require 'package-module)

;; yasnippet
(package-require 'yasnippet)

(package-require 'elixir-yasnippets)
(package-require 'common-lisp-snippets)
(package-require 'clojure-snippets)

(require 'yasnippet)

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(yas-reload-all)

(define-key yas-minor-mode-map (kbd "M-SPC") yas-maybe-expand)

(define-key yas-minor-mode-map (kbd "s-y") #'yas-expand)
(define-key yas-minor-mode-map (kbd "C-c C-y") #'yas-expand)

(add-hook 'lisp-mode-hook #'yas-minor-mode)
(add-hook 'clojure-mode-hook #'yas-minor-mode)
(add-hook 'elixir-mode-hook #'yas-minor-mode)

(add-hook 'rustic-mode-hook #'yas-minor-mode)

(defun expand-yasnippet (name)
  (interactive)
  (yas-expand-snippet (yas-lookup-snippet name)))

(defconst *lisp-snippets* '((?f . "df")
			    (?l . "lambda-2")
			    (?a . "lambda")
			    (?e . "let")
			    (?i . "if-let")
			    (?w . "when-let")
			    (?b . "db")
			    (?v . "dv")
			    (?p . "dp")
			    (?m . "mvb")))

(defun insert-lisp-snippet ()
  (interactive)
  (let ((s (cdr (assoc last-input-event *lisp-snippets*))))
    (expand-yasnippet s)))

(defun bind-snippet-keys (mode-map snippets function)
  (dolist (s (mapcar #'car snippets))
    (define-key lisp-mode-map (kbd (format "\e\e%c" s)) function)))

(eval-after-load 'lisp-mode
  '(progn
     (bind-snippet-keys lisp-mode-map *lisp-snippets* #'insert-lisp-snippet)))

(provide 'snippets-module)
