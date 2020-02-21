;; package-module

(require 'package)
(require 'cl)

(setq package-check-signature nil) 
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(when (boundp 'package-pinned-packages)
  (setq package-pinned-packages
	'((clojure-mode . "melpa-stable")
	  (clojure-mode-extra-font-locking . "melpa-stable")
	  (cider . "melpa-stable")
	  (flycheck . "melpa-stable")
	  (ace-jump-mode . "melpa-stable")
	 ;; (perspective . "melpa-stable")
	  (exec-path-from-shell . "melpa-stable")
	  (company . "melpa-stable")
	  (ag . "melpa-stable")
	  (haskell-mode . "melpa-stable")
	  ;; --

	  (cargo . "melpa-stable")
;;          (flycheck-rust . "melpa-stable")
	  (rust-mode . "melpa-stable")
	  (racer . "melpa-stable")
	  (rust-playground . "melpa-stable")

  	  (idris-mode . "melpa-stable")
	  (hindent . "melpa-stable")
	  (ghc . "melpa-stable")
	  (lua-mode . "melpa-stable")
	  (slime . "melpa-stable")
	  (slime-company . "melpa-stable")
	  (company-ghc . "melpa-stable")
	  (paredit . "melpa-stable")
	  (magit . "melpa-stable")
	  (inf-ruby . "melpa-stable")
	  (flymake-ruby . "melpa-stable")
	  (yasnippet . "melpa-stable")
	  (solarized-theme . "melpa-stable")
	  (ensime . "melpa-stable")
	  (clj-refactor . "melpa")
	 ;; (moe-theme . "melpa")
 	  (geiser . "melpa")
 	  (ac-geiser . "melpa")
	  (intero . "melpa")
 	  (alchemist . "melpa")
  	  (elixir-mode . "melpa")
  	  (elixir-yasnippets . "melpa")
  	  (flycheck-credo . "melpa")
	  (projectile . "melpa")
	  (org . "gnu")
	  (sml-mode . "gnu"))))

(package-initialize)

(defun online? ()
  (if (and (functionp 'network-interface-list)
           (network-interface-list))
      (some (lambda (iface) (unless (equal "lo" (car iface))
                         (member 'up (first (last (network-interface-info
                                                   (car iface)))))))
            (network-interface-list))
    t))

(defun package-require (pkg)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

(when (online?)
  (unless package-archive-contents (package-refresh-contents)))

(provide 'package-module)
