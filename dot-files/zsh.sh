
export PATH=/usr/local/git/libexec/git-core:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$PATH

export EDITOR='emacs'

export SSH_KEY_PATH="~/.ssh/id_rsa"

# java

export M2_HOME=/Users/maris/bin/apache-maven

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7/Contents/Home

export PATH=$JAVA_HOME/Contents/Home/bin:$M2_HOME/bin:$PATH

# emacs

alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
alias em="/Applications/Emacs.app/Contents/MacOS/Emacs"

# git

alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | kaleidoscope'
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

alias mcp='maven clean package'
alias mci='maven clean install'

# tmux

alias tma='tmux attach -t'
alias tml='tmux list-sessions'

[[ -z "$TMUX" ]] && exec tmux
