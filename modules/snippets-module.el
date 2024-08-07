;; snippets-module

(require 'package-module)

;; yasnippet
(package-require 'yasnippet)

(package-require 'elixir-yasnippets)
(package-require 'common-lisp-snippets)
(package-require 'clojure-snippets)

(require 'yasnippet)

;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)

(yas-reload-all)

;; (define-key yas-minor-mode-map (kbd "s-y") #'yas-expand)
(define-key yas-minor-mode-map (kbd "C-c C-y") #'yas-maybe-expand)

(add-hook 'elixir-ts-mode-hook #'yas-minor-mode)

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

(defconst *rust-snippets* '((?o . "for")
			    (?l . "log")
			    (?i . "if let")
			    (?m . "match expression { ... }")
			    (?f . "fn")))

(defconst *clojure-snippets* '((?a . "defmacro2")
			       (?b . "map lambda")
			       (?c . "cond")
			       (?d . "def")
			       (?e . "reduce")
                               (?f . "defn2")
                               (?g . "testing")
			       (?h . "whenl")
			       (?i . "if")
			       (?j . "letfn")
			       (?k . "keep")
                               (?l . "let")
			       (?m . "map")
			       (?n . "fn")
			       (?o . "opts")
			       (?p . "print")
			       (?q . "require")
			       (?r . "for")
			       (?s . "doseq")
			       (?t . "test")
			       (?u . "filter")
			       (?v . "case")
			       (?w . "when")
			       (?x . "defmulti")
                               (?y . "ifl")
			       (?z . "try")))

(defconst *elixir-snippets* '((?c . "cond")
			      (?d . "def")
			      (?p . "defp")
			      (?g . "genserver")
			      (?i . "if")
			      (?o . "for")
			      (?l . "unless")
			      (?n . "fn")
			      (?r . "receive")
			      (?v . "case")
			      (?t . "test")
			      ))

(defun insert-lisp-snippet ()
  (interactive)
  (let ((s (cdr (assoc last-input-event *lisp-snippets*))))
    (expand-yasnippet s)))

(defun insert-rust-snippet ()
  (interactive)
  (let ((s (cdr (assoc last-input-event *rust-snippets*))))
    (expand-yasnippet s)))

(defun insert-clojure-snippet ()
  (interactive)
  (let ((s (cdr (assoc last-input-event *clojure-snippets*))))
    (expand-yasnippet s)))

(defun insert-elixir-snippet ()
  (interactive)
  (let ((s (cdr (assoc last-input-event *elixir-snippets*))))
    (expand-yasnippet s)))

(defun bind-snippet-keys (mode-map snippets function)
  (dolist (s (mapcar #'car snippets))
    (define-key mode-map (kbd (format "\e\e%c" s)) function)))

(defun bind-lisp-snippets (mode-map)
  (bind-snippet-keys mode-map *lisp-snippets* #'insert-lisp-snippet))

(defun bind-rust-snippets (mode-map)
  (bind-snippet-keys mode-map *rust-snippets* #'insert-rust-snippet))

(defun bind-clojure-snippets (mode-map)
  (bind-snippet-keys mode-map *clojure-snippets* #'insert-clojure-snippet))

(defun bind-elixir-snippets (mode-map)
  (bind-snippet-keys mode-map *elixir-snippets* #'insert-elixir-snippet))

(provide 'snippets-module)
