
# Emacs

export EDITOR="$HOME/bin/run-emacsclient-cli"
export VISUAL="$EDITOR"
export ALTERNATE_EDITOR="vim"

alias em="$HOME/bin/run-emacs"
alias ec="$HOME/bin/run-emacsclient"
alias e="$HOME/bin/run-emacsclient-cli"
alias notes='$HOME/bin/run-emacsclient-cli -e "(deft)"'

emacs_open_buffer()
{
    run-emacsclient-cli -e "(let ((b (find-buffer-by-prefix \"$1\"))) nil)"
}
alias eb=emacs_open_buffer

# maven

export MAVEN_OPTS="-Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m"

alias aws_prod='source ~/bin/aws-prod'
alias aws_dev='source ~/bin/aws-dev'

# tmux

alias tma='tmux attach -t'
alias tml='tmux list-sessions'

# verbose
for c in cp rm chmod chown mv; do
    alias $c="$c -v"
done

# history

HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
