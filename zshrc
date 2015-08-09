#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export TERM=xterm-256color
if [[ $platform == 'linux' ]]; then
    eval "$(dircolors ~/.dir_colors)"
elif [[ $platform == 'osx' ]]; then
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux

#local
source ~/.zshrc.local

# Fzf source
source ~/.fzf.zsh

#nvm
export NVM_DIR="/home/wwang/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
