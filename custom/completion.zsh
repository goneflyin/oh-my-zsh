unsetopt correctall

# add brew completion function to path
fpath=($ZSH/custom/completion $fpath)
autoload -U compinit
compinit -i
