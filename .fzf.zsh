# Setup fzf function
# ------------------
unalias fzf 2> /dev/null
fzf() {
  /usr/bin/ruby --disable-gems $HOME/.fzf/fzf "$@"
}
export -f fzf > /dev/null

# Auto-completion
# ---------------
source $HOME/.fzf/fzf-completion.zsh

# Key bindings
# ------------
# CTRL-T - Paste the selected file path(s) into the command line
fzf-file-widget() {
  local FILES
  local IFS="
"
  FILES=($(
    find * -path '*/\.*' -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | fzf -m))
  unset IFS
  FILES=$FILES:q
  LBUFFER="${LBUFFER%% #} $FILES"
  zle redisplay
}
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

# ALT-C - cd into the selected directory
fzf-cd-widget() {
  cd "${$(find * -path '*/\.*' -prune \
          -o -type d -print 2> /dev/null | fzf):-.}"
  zle reset-prompt
}
zle     -N    fzf-cd-widget
bindkey '\ec' fzf-cd-widget

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  LBUFFER=$(fc -l 1 | fzf +s | sed "s/ *[0-9]* *//")
  zle redisplay
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

# Extra functions
# ---------------
# vimf - Open selected file in Vim
vimf() {
  local file
  file=$(fzf --query="$1") && vim "$file"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fh - repeat history
fh() {
  eval $(history | fzf +s | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
  ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf +s +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

# fco - checkout git commit
fco() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fq1 [QUERY]
# - Immediately select the file when there's only one match.
#   If not, start the fuzzy finder as usual.
fq1() {
  local lines
  lines=$(fzf --filter="$1" --no-sort)
  if [ -z "$lines" ]; then
    return 1
  elif [ $(wc -l <<< "$lines") -eq 1 ]; then
    echo "$lines"
  else
    echo "$lines" | fzf --query="$1"
  fi
}

# fe [QUERY]
# - Open the selected file with the default editor
#   (Bypass fuzzy finder when there's only one match)
fe() {
  local file
  file=$(fq1 "$1") && ${EDITOR:-vim} "$file"
}
