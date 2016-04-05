#!/bin/bash
#############################
# Download files config files
#
#############################

# Download prereqs
#cat prereqs.txt | xargs -n 1 brew install

# Download prezto
if [ ! -d ~/.oh-my-zsh/ ]; then
   git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
fi

# Downlaod tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm/ ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Download and install fzf
if [ ! -d ~/.fzf/ ]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
fi
