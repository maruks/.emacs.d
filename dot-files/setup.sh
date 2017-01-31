#!/bin/bash

platform=`uname`

if [[ $platform == 'Linux' ]]; then
    ln -s ~/.emacs.d/dot-files/zsh.linux.sh ~/zsh.sh
elif [[ $platform == 'Darwin' ]]; then
    ln -s ~/.emacs.d/dot-files/zsh.osx.sh ~/zsh.sh
fi

mkdir -p ~/.lein
mkdir -p ~/.ssh

cp ~/.emacs.d/dot-files/.zshrc ~
cp ~/.emacs.d/dot-files/.gitconfig ~
cp ~/.emacs.d/dot-files/profiles.clj ~/.lein
cp ~/.emacs.d/dot-files/config ~/.ssh

ln -s ~/.emacs.d/dot-files/tmux.conf ~/.tmux.conf
