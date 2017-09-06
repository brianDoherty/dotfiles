## symlinks
ln -s ~/.zshrc ~/src/dotfiles/.zshrc;
ln -s ~/.vimrc ~/src/dotfiles/.vimrc;
ln -s ~/.tmux.conf ~/src/dotfiles/.tmux.conf;
ln -s ~/.gitconfig ~/src/dotfiles/.gitconfig;

## install nvm and node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash;
nvm install node;

## npm stuff
npm install -g diff-so-fancy;
npm install -g eslint;

## Home brew stuff
# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Terminal stuff
brew install zsh;
brew install tmux;
brew install reattach-to-user-namespace;

# Editors
brew install vim;
brew install neovim;

# Helpful tools
brew install git;
brew install exa;
brew install jq;
brew install ag;
brew install tree;
brew install fzf;
brew install gource;
brew install cowsay;
brew install fortune;

## Git repos
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier;

# vundle install
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim;
# install vim plugins
vim +PluginInstall +qall;
