;; hydra-module

(require 'package-module)

(package-require 'hydra)
;(package-require 'cider-hydra)

;;(add-to-list 'load-path "~/.emacs.d/vendor/hydra")
;; (require 'cider-hydra)

;; (define-key map (kbd "C-c C-d") #'cider-hydra-doc/body)
;; (define-key map (kbd "C-c C-t") #'cider-hydra-test/body)
;; (define-key map (kbd "C-c M-t") #'cider-hydra-test/body)
;; (define-key map (kbd "C-c M-r") #'cider-hydra-repl/body)

;; (add-hook 'cider-mode-hook
;; 	  (lambda ()
;; 	    (cider-hydra-mode)))

;; dired
(defhydra hydra-dired (:hint nil :color pink)
  "
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir
_C_opy             _O_ view other   _U_nmark all       _T_ouch            _$_ hide-subdir
_D_elete marked    _o_pen other     _u_nmark           _l_ redisplay      _w_ copy file name
_R_ename           _M_ chmod        _t_oggle           _g_ refresh        _f_ visit file
_Y_ rel symlink    _G_ chgrp        _&_ shell command  _s_ort             _=_ diff
_A_ find regexp    _Q_ repl regexp  _c_ compress to    _Z_ compress or uncompress marked
_S_ymlink          _r_sync          _?_ summary        _._ toggle hydra
"
  ("c" dired-do-compress-to)
  ("Z" dired-do-compress)
  ("f" dired-find-file)
  ("&" dired-do-async-shell-command)
  ("(" dired-hide-details-mode)
  ("+" dired-create-directory)
  ("=" diredp-diff)
  ("T" dired-do-touch)
  ("?" dired-summary)
  ("$" diredp-hide-subdir-nomove)
  ("A" dired-do-find-regexp)
  ("C" dired-do-copy)        ;; Copy all marked files
  ("D" dired-do-delete)
  ("F" dired-do-find-marked-files)
  ("G" dired-do-chgrp)
  ("g" revert-buffer)        ;; read all directories again (refresh)
  ("i" dired-maybe-insert-subdir)
  ("l" dired-do-redisplay)   ;; relist the marked or singel directory
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("O" dired-display-file)
  ("o" dired-find-file-other-window)
  ("Q" dired-do-find-regexp-and-replace)
  ("R" dired-do-rename)
  ("r" dired-do-rsynch)
  ("S" dired-do-symlink)
  ("s" dired-sort-toggle-or-edit)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
  ("w" dired-copy-filename-as-kill)
  ("Y" dired-do-relsymlink)
  ("z" diredp-compress-this-file)
  ("Z" dired-do-compress)
  ("q" nil)
  ("." nil :color blue))

(eval-after-load "dired"
  (lambda ()
    (define-key dired-mode-map "." 'hydra-dired/body)))

;; erlang
;; (defhydra eunit-hydra-test (:color blue)
;;   "
;; EUNIT Test
;; ---------------------------------------------------------------------------
;; _t_: Toggle source and test file
;; _j_: Run current test                   _v_: Cover compile
;; _k_: Run module tests                   _c_: Run module tests under cover
;; _l_: Run recent tests                   _a_: Analyze coverage
;; "

;;   ("a" erlang-eunit-analyze-coverage nil)
;;   ("c" erlang-eunit-compile-and-run-module-tests-under-cover nil)
;;   ("j" erlang-eunit-compile-and-run-current-test nil)
;;   ("k" erlang-eunit-compile-and-run-module-tests nil)
;;   ("l" erlang-eunit-compile-and-run-recent nil)
;;   ("t" erlang-eunit-toggle-src-and-test-file-other-window nil)
;;   ("v" erlang-eunit-cover-compile nil))

;; (with-eval-after-load 'erlang
;;   (define-key erlang-mode-map (kbd "C-c C-t") #'eunit-hydra-test/body))

(provide 'hydra-module)
