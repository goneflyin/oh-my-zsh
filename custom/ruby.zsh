# -*- shell-script -*-

# Configuration for RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export JRUBY_INVOCATION="$(readlink "$(which celerity_jruby)")"

# Convenient.  Also works in Gentoo or Ubuntu
if [[ -x `which irb1.8` ]]; then
  alias irb='irb1.8 --readline -r irb/completion'
else
  alias irb='irb --readline -r irb/completion'
fi
export RI='-f ansi --width 70'

# No idea what fri is -- will have to look it up and see if it's useful (4-Feb-09)
if [[ -x `which fri` ]]; then
  alias ri=fri
fi
