#!/bin/bash
#############################
# Download files config files
#
#############################

# Download prereqs
cat prereqs.txt | xargs -n 1 sudo apt-get install -y

# Download prezto
if [ ! -d ~/.oh-my-zsh/ ]; then
   git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
fi

# Download bash_it
if [ ! -d ~/bash_it/ ]; then
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
fi

# Downlaod tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm/ ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Download and install fzf
if [ ! -d ~/.fzf/ ]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
fi

if [ ! -d ~/.config/up/ ]; then
    curl --create-dirs -o ~/.config/up/up.sh https://raw.githubusercontent.com/shannonmoeller/up/master/up.sh
fi
