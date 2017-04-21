export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sorin"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git zsh-syntax-highlighting vi-mode jira web-search)

source $ZSH/oh-my-zsh.sh

source $HOME/.localrc

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/usr/local/bin:$PATH
export TERM='xterm-256color'
export EDITOR=/usr/local/bin/vim

export JIRA_URL=https://jira.cainc.com
export JIRA_NAME=bdoherty
export JIRA_DEFAULT_ACTION=dashboard

alias vim=nvim
# Fix issue with tmux navigator not working with neo vim https://github.com/christoomey/vim-tmux-navigator/issues/61
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti

# Diff two urls
vimdiff_urls() { vimdiff <(curl -s ${1}) <(curl -s ${2}) }
alias vdu=vimdiff_urls

function t {
    tree -C --prune --ignore-case  -I "*node_modules*|*jspm_packages*|*reports*" -P "*$1*"
}

function root {
    git rev-parse && cd "$(git rev-parse --show-cdup)";
}

function work {
    tmuxifier w $1;
}

function digit {
    tmuxifier s digit;
}

function morning {
    open /Applications/Safari.app;
    open /Applications/Google\ Chrome.app;
    open /Applications/Slack.app;
    open /Applications/Airmail\ 2.app;
    open /Applications/OpenVPN/OpenVPN\ Connect.app;
    open /Applications/Calendar.app;
    digit;
}

function j {
    jira $(git rev-parse --abbrev-ref HEAD);
}

export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# VI Mode stuff
bindkey '^r' history-incremental-search-backward
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# NVM Stuff
export NVM_DIR="/Users/bdoherty/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


# fzf stuff
export FZF_DEFAULT_COMMAND='ag -g ""'
_fzf_compgen_path() {
  ag -g "" "$1"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
