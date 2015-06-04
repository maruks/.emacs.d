;; appearance-module

(require 'package-module)

(menu-bar-mode -1)
(setq inhibit-startup-screen 1)

(if (and window-system (boundp 'tool-bar-mode))
    (tool-bar-mode -1))
(if
    (boundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(show-paren-mode 1)

(provide 'appearance-module)
