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

# Environment Variables {{{
export PATH="$HOME/.local/lib/python2.7/site-packages/powerline:$HOME/.local/bin:$PATH"

export JAVA_HOME=/usr/lib/jvm/java-8-oracle/

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

#---------------------------------------------------------------------------}}}
# Colors {{{
export TERM=xterm-256color
if [[ $platform == 'linux' ]]; then
    eval "$(dircolors ~/.dir_colors)"
elif [[ $platform == 'osx' ]]; then
    eval "$(gdircolors ~/.dir_colors)"
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#---------------------------------------------------------------------------}}}
# Aliases {{{
if [[ $platform == 'linux' ]]; then
    source ~/.linuxaliases
elif [[ $platform == 'osx' ]]; then
    source ~/.osxaliases
fi
#---------------------------------------------------------------------------}}}
# Start Tmux automatically {{{
#[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux
#---------------------------------------------------------------------------}}}
# Fzf source
source ~/.fzf.zsh

#local
source ~/.zshrc.local

#nvm
export NVM_DIR="/home/wwang/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
