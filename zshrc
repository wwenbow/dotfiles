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

if [[ $TERM == 'xterm' ]]; then
    export TERM=xterm-256color
fi

if [[ $platform == 'linux' ]]; then
    eval "$(dircolors ~/.dir_colors)"
elif [[ $platform == 'osx' ]]; then
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux
#
#Fix for neovim c-h
export TERMINFO="$HOME/.terminfo"
export EDITOR="nvim"

#local
if [ -e "$HOME/.zshrc.local" ] ; then
    source ~/.zshrc.local
fi

# Fzf source
source ~/.fzf.zsh
