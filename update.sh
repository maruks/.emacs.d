#!/bin/sh

rm -rf clojure-mode
rm -rf framemove
rm -rf paredit
rm -rf themes

git clone https://github.com/technomancy/clojure-mode.git
git clone git://github.com/bbatsov/zenburn-emacs.git themes

wget -P framemove  http://www.emacswiki.org/emacs/download/framemove.el
wget -P paredit http://mumble.net/~campbell/emacs/paredit.el

rm -rf clojure-mode/.git
rm -rf themes/.git
rm themes/README.md              
rm themes/color-theme-zenburn.el
rm themes/color-theme.el