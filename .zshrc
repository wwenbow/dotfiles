# ZSHRC
# wenbo wang
#
#
# Oh My Zsh {{{
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#$ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster-old"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python command-not-found compleat zsh-syntax-highlighting history-substring-search)

source $ZSH/oh-my-zsh.sh

#---------------------------------------------------------------------------}}}
# User configuration {{{

export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:\
    /usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:\
    /usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:\
    /usr/lib/jvm/java-7-oracle/jre/bin"
export PATH="$HOME/.local/lib/python2.7/site-packages/powerline:$HOME/.local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
#---------------------------------------------------------------------------}}}
# Colors {{{
export TERM=xterm-256color
eval "$(dircolors ~/.dir_colors)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#---------------------------------------------------------------------------}}}
# Aliases {{{
alias ls='ls -XF --color=auto --group-directories-first'
alias la='ls -A'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rm='rm -vfr'
alias cp='cp -ivR'
alias mv='mv -iv'
alias du='du -ch'
alias df='df -H'
alias bc='bc -l'
alias mkdir='mkdir -pv'
alias cd..='cd ..'
alias g='xdg-open'
alias ln='ln -v'
#---------------------------------------------------------------------------}}}
# Start Tmux automatically
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux
