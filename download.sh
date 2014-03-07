#!/bin/bash
#############################
# Download files config files
#
#############################

# Download oh-my-zsh
if [ ! -d .oh-my-zsh/ ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/dotfiles/.oh-my-zsh
fi
# copy old agnoster theme to oh-my-zsh themes
if [ ! -e ~/dotfiles/.oh-my-zsh/themes/agnoster-old.zsh-themes ]; then
    cp agnoster-theme/agnoster-old.zsh-theme ~/dotfiles/.oh-my-zsh/themes/
fi
# Download zsh-syntax-highlight
if [ ! -d .oh-my-zsh/plugins/zsh-syntax-highlighting/ ]; then
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git \
        ~/dotfiles/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi
