local theme_dir theme_file_template

# Get all the themes available
theme_dir=$ZSH/themes
theme_file_template=$theme_dir/*.zsh-theme

list_themes() {
    for file in ${~theme_file_template}; do
	theme=${file:t:r}
	echo $theme
    done
}

typeset -A theme_file_map
for file in ${~theme_file_template}; do
    theme=${file:t:r}
    theme_file_map[$theme]=$file
done

#
# theme preview:
#   1. 
#
prompt_preview_safely() {
  emulate -L zsh
  print -P "%b%f%k"
  if [[ -z "$theme_file_map[(r)$1]" ]]; then
    print "Unknown theme: $1"
    return
  fi

  local -a psv; psv=($psvar); local -a +h psvar; psvar=($psv) # Ick
  local +h PS1=$PS1 PS2=$PS2 PS3=$PS3 PS4=$PS4 RPS1=$RPS1
  local -a precmd_functions preexec_functions

  # The next line is a bit ugly.  It (perhaps unnecessarily)
  # runs the prompt theme setup function to ensure that if
  # the theme has a _preview function that it's been autoloaded.
  prompt_${1}_setup

  if typeset +f prompt_${1}_preview >&/dev/null; then
    prompt_${1}_preview "$@[2,-1]"
  else
    prompt_preview_theme "$@"
  fi
}

prompt_preview_theme () {
  emulate -L zsh
  local -a psv; psv=($psvar); local -a +h psvar; psvar=($psv) # Ick
  local +h PS1=$PS1 PS2=$PS2 PS3=$PS3 PS4=$PS4 RPS1=$RPS1
  local precmd_functions preexec_functions

  print -n "$1 theme"
  (( $#* > 1 )) && print -n " with parameters \`$*[2,-1]'"
  print ":"
  prompt_${1}_setup "$@[2,-1]"
  [[ -n ${precmd_functions[(r)prompt_${1}_precmd]} ]] &&
    prompt_${1}_precmd
  [[ -o promptcr ]] && print -n $'\r'; :
  print -P "${PS1}command arg1 arg2 ... argn"
  [[ -n ${preexec_functions[(r)prompt_${1}_preexec]} ]] &&
    prompt_${1}_preexec
}
