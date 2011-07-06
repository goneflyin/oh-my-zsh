#
# Override/correct any oh-my-zsh default settings necessary
#
HISTSIZE=50000
SAVEHIST=50000
$(alias history > /dev/null) && unalias history

swhi() {
  if [[ -n $1 ]]; then
    source $ZSH/custom/_${1}h
  fi
}

# Grep the history with 'h'
h () { history 0 | grep $1 }

