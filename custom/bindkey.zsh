# -*- shell-script -*-

source ~/.zkbd/$TERM-$VENDOR-$OSTYPE

# Taken VERBATIM from my former zshrc:
#
#binding is based on $EDITOR and $VISUAL settings.  bah.
bindkey -e
# make ctrl-left,right skip words
if [[ -n $USING_CYGWIN ]]; then
  bindkey ";5D" backward-word
  bindkey ";5C" forward-word
  elif [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    bindkey "^[[5C" forward-word
    bindkey "^[[5D" backward-word
  else # $TERM_PROGRAM probably == "iTerm.app"
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word
fi

# Taken VERBATIM from zshkit:
#
#bindkey "${key[Home]}" beginning-of-line
#bindkey "${key[End]}" end-of-line

bindkey "  " globalias
bindkey " " magic-space

bindkey "^Og" noglob-command-line
bindkey "^Os" sudo-command-line
