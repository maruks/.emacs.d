;; -*- lexical-binding: t; -*-

(setq warning-suppress-types '((lexical-binding)))
(setq warning-inhibit-types '((files missing-lexbind-cookie)))


;; Disable menu bar, tool bar, and scroll bar for all frames
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
