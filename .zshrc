# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sorin"

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

export EDITOR='vim'

export PATH=/usr/local/bin:$PATH
export TERM='xterm-256color'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home"

# tell system to use gcc instead of clang, only used for compiling gems
export CC=$(brew --prefix)/Cellar/gcc48/4.8.4/bin/gcc-4.8
export CXX=$(brew --prefix)/Cellar/gcc48/4.8.4/bin/g++-4.8
export CPP=$(brew --prefix)/Cellar/gcc48/4.8.4/bin/cpp-4.8

# Fix for OpenSSL and readline problems
export LDFLAGS='-L/usr/local/opt/openssl/lib -L/usr/local/opt/readline/lib'
export CPPFLAGS='-I/usr/local/opt/openssl/include -I/usr/local/opt/readline/include'

source ~/.nvm/nvm.sh

source ~/.profile
. `brew --prefix`/etc/profile.d/z.sh

alias fuck='$(thefuck $(fc -ln -1))'
alias charlesvpn-on='sudo ruby /Users/bdoherty/projects/helpful-scripts/network/charles-vpn.rb -a'
alias charlesvpn-off='sudo ruby /Users/bdoherty/projects/helpful-scripts/network/charles-vpn.rb -d'

export BROWSERSTACK_USER=bdoherty
export BROWSERSTACK_KEY=UcspzQdppdpXE1CCUsy2

# Diff two urls
vimdiff_urls() { vimdiff <(curl -s ${1}) <(curl -s ${2}) }
alias vdu=vimdiff_urls
