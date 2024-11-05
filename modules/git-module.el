;; git-module

(require 'package-module)

;; magit

(use-package magit
  :commands (magit-status magit-blame)

  :bind
  (("s-m" . magit-status)
   ("C-x M-b" . magit-blame)))

(use-package git-timemachine
  :bind
  (("s-t" . git-timemachine-toggle)))

(use-package difftastic
  :demand t
  :bind (:map magit-blame-read-only-mode-map
         ("D" . difftastic-magit-show)
         ("S" . difftastic-magit-show))
  :config
  (eval-after-load 'magit-diff
    '(transient-append-suffix 'magit-diff '(-1 -1)
       [("D" "Difftastic diff (dwim)" difftastic-magit-diff)
        ("S" "Difftastic show" difftastic-magit-show)])))

(provide 'git-module)
