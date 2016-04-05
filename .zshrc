export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sorin"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git zsh-syntax-highlighting vi-mode jira)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/usr/local/bin:$PATH
export TERM='xterm-256color'

export JIRA_URL=https://jira.roving.com
export JIRA_NAME=bdoherty

# Diff two urls
vimdiff_urls() { vimdiff <(curl -s ${1}) <(curl -s ${2}) }
alias vdu=vimdiff_urls

function t {
    tree -C --prune --ignore-case  -I "*node_modules*|*jspm_packages*|*reports*" -P "*$1*"
}

function work {
    tmuxifier w $1;
}

export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# VI Mode stuff
bindkey '^r' history-incremental-search-backward
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

export NVM_DIR="/Users/bdoherty/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
