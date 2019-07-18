export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sorin"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git zsh-auto-suggestions zsh-syntax-highlighting vi-mode jira web-search)

source $ZSH/oh-my-zsh.sh

source $HOME/.localrc

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/usr/local/bin:$PATH
# export TERM='xterm-256color'
export TERM='xterm-256color-italic'
export EDITOR=/usr/local/bin/vim

export JIRA_URL=https://cainc.com
export JIRA_NAME=bdoherty
export JIRA_DEFAULT_ACTION=dashboard

alias ll="exa -l --git"
alias vim=nvim
# Fix issue with tmux navigator not working with neo vim https://github.com/christoomey/vim-tmux-navigator/issues/61
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti

# Diff two urls
vimdiff_urls() { vimdiff <(curl -s ${1}) <(curl -s ${2}) }
alias vdu=vimdiff_urls

function freshstart {
  root;
  git clean -fxd;
  ./scripts/yarn-all.sh;
  cd PageEditorUI;
  bend reactor serve --update . ../ContentEditorUI ../InpageEditorUI
}

function tsconfig {
  #root;
  for dir in ./*UI
  do
    cd $dir;
    echo $dir;
    bend generate-tsconfig;
    cd ..;
  done
}

function t {
    tree -a -C --prune --ignore-case  -I "*node_modules*|*jspm_packages*|*reports*" -P "*$1*"
}

function root {
    git rev-parse && cd "$(git rev-parse --show-cdup)";
}

function work {
    tmuxifier w $1;
}

function hubspot {
  open "https://local.hubspotqa.com/content/99563647/edit/3234867526/content";
  tmuxifier s hubspot;
}

function morning {
    open /Applications/Google\ Chrome.app;
    open /Applications/Slack.app;
    open /Applications/Spark.app;
    open /Applications/Calendar.app;
    hubspot;
}

function j {
    jira $(git rev-parse --abbrev-ref HEAD);
}

function gif {
  source ~/src/dotfiles/get_right_gif $1
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

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Added by nex: https://git.hubteam.com/HubSpot/nex
. ~/.hubspot/shellrc
