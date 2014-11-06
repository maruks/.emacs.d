# plugins

plugins=(git command-not-found lein)

# docker

export DOCKER_HOST=tcp://127.0.0.1:4243

# git

alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gau='git add --update'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias glog='git log'
alias glogp='git log --pretty=format:"%h %s" --graph'

# leiningen

alias luj='lein uberjar'

# maven

export MAVEN_OPTS="-Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m"

alias mcp='maven clean package'
alias mci='maven clean install'

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
