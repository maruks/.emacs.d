#!/bin/bash

mkdir -p ~/.lein
mkdir -p ~/.ssh

cp ~/.emacs.d/dot-files/.zshrc ~
cp ~/.emacs.d/dot-files/.gitconfig ~
cp ~/.emacs.d/dot-files/profiles.clj ~/.lein
cp ~/.emacs.d/dot-files/config ~/.ssh

ln -s ~/.emacs.d/dot-files/tmux.conf ~/.tmux.conf
