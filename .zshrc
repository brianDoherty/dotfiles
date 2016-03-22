export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sorin"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git zsh-syntax-highlighting vi-mode jira)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/usr/local/bin:$PATH
export TERM='xterm-256color'

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home"

# Fix for OpenSSL and readline problems
export LDFLAGS='-L/usr/local/opt/openssl/lib -L/usr/local/opt/readline/lib'
export CPPFLAGS='-I/usr/local/opt/openssl/include -I/usr/local/opt/readline/include'

source ~/.profile

alias fuck='$(thefuck $(fc -ln -1))'
alias charlesvpn-on='sudo ruby /Users/bdoherty/old_project_repos/helpful-scripts/network/charles-vpn.rb -a'
alias charlesvpn-off='sudo ruby /Users/bdoherty/old_project_repos/helpful-scripts/network/charles-vpn.rb -d'

export BROWSERSTACK_USER=bdoherty
export BROWSERSTACK_KEY=UcspzQdppdpXE1CCUsy2

export JIRA_URL=https://jira.roving.com
export JIRA_NAME=bdoherty

# Diff two urls
vimdiff_urls() { vimdiff <(curl -s ${1}) <(curl -s ${2}) }
alias vdu=vimdiff_urls

function work {
    tmuxifier w $1;
}

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh



export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# VI Mode stuff
bindkey '^r' history-incremental-search-backward
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
