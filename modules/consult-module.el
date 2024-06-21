;; consult-module

(require 'package-module)

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("s-l" . consult-register-load)
         ("s-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-'" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ;; ("s-g" . nil)
         ;; ("s-g e" . consult-compile-error)
         ;; ("s-g f" . consult-flycheck)
         ;; ("s-g g" . consult-goto-line)             ;; orig. goto-line
         ;; ("s-g s-g" . consult-goto-line)           ;; orig. goto-line
         ;; ("s-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ;; ("s-g m" . consult-mark)
         ;; ("s-g k" . consult-global-mark)
	 ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flycheck)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-i" . consult-imenu)
         ("M-I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("s-s" . nil)
         ("s-s d" . consult-find)
         ("s-s D" . consult-locate)
         ("s-s g" . consult-grep)
         ("s-s G" . consult-git-grep)
         ("s-a" . consult-ripgrep)     ;;
         ("s-s l" . consult-line)
         ("s-s L" . consult-line-multi)
         ("s-s k" . consult-keep-lines)
         ("s-s u" . consult-focus-lines)
         ;; Isearch integration
         ("s-s e" . consult-isearch-history)
         ;; :map isearch-mode-map
         ("s-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("s-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("s-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("s-s" . consult-history)                 ;; orig. next-matching-history-element
	 ("s-r" . consult-history)                 ;; orig. previous-matching-history-element
	 )


  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  (recentf-mode 1)
  (setq recentf-max-menu-items 20)

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root))))


(use-package consult-dir
  :ensure t
  :bind (("C-x C-d" . consult-dir)
         :map vertico-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file))

  :config
  (setq consult-dir-project-list-function #'consult-dir-projectile-dirs))

(use-package consult-yasnippet
  :ensure t
  :bind (("s-n" . consult-yasnippet))
  )

(use-package consult-flycheck
  :ensure t)

(use-package consult-eglot
  :ensure t)

;; (use-package consult-git-log-grep
;;   :custom
;;   (consult-git-log-grep-open-function #'magit-show-commit))

(use-package consult-projectile
  :ensure t
  :bind
  ("C-x p p" . consult-projectile)
  ("s-f" . consult-projectile-find-file)
  ("s-g" . nil)
  ("s-g d" . consult-projectile-find-dir)
  ("s-e" . consult-projectile-recentf)
  ("s-b" . consult-projectile-switch-to-buffer))

(provide 'consult-module)
