#!/bin/bash

# brew install
# difftastic fzf the_silver_searcher ripgrep

mkdir -p ~/.lein
mkdir -p ~/.ssh

cp ~/.emacs.d/dot-files/.zshrc ~
cp ~/.emacs.d/dot-files/.zshenv ~
cp ~/.emacs.d/dot-files/.gitconfig ~
cp ~/.emacs.d/dot-files/.tmux.conf ~

cp ~/.emacs.d/dot-files/profiles.clj ~/.lein
cp ~/.emacs.d/dot-files/config ~/.ssh
