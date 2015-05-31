;; snippets-module

(require 'package-module)

;; yasnippet
(package-require 'yasnippet)

(require 'yasnippet)

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

(yas-reload-all)

(add-hook 'clojure-mode-hook
          '(lambda ()
             (yas-minor-mode)))

(provide 'snippets-module)
