(load "~/.emacs.d/slime/swank-loader.lisp")
(swank-loader:init)
(swank:create-server :port 55555)
