# emacs

alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
alias em="/Applications/Emacs.app/Contents/MacOS/Emacs"
alias ec="emacsclient -n"

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
