;; package-module

(require 'package)
(require 'cl)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

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
