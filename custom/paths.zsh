# -*- mode: shell-script; tab-width: 2 -*-

typeset -gU path cdpath manpath fpath

#
# FPATH init
#
# fpath=( $ZSH/zsh-functions /opt/local/share/zsh/site-functions $fpath )
# TODO: use a variable to get zsh-home directory somehow
#fpath=( $ZSH/zsh-functions /usr/local/share/zsh/site-functions $fpath )

#
#   ...and autoload all functions defined in my fpath dir
#
#  ${fpath[1]} -- substitute index 1 of array variable 'fpath'
#  .../*       -- use globbing; expand to all filenames within directory
#  ...(:t)     -- modify expanded argument ... keep Only trailing component
#
#autoload -U ${fpath[1]}/*(:t)
#autoload -U ${fpath[2]}/*(:t)

# TODO: Make macports dirs conditional based upon platform

# 
# PATH init
#
pathdirs=(
    /usr/local/git/bin
    /bin
    /usr/local/sbin
    /opt/local/bin               # macports bin dir
    /opt/local/sbin              # macports sbin dir
    /opt/local/libexec/git-core  # contains old-style git cmds (git-pull vs. git pull)
    /opt/local/share/scala/bin
    ~/bin 
		/usr/local/Cellar/tomcat/6.0.26/bin
)

# TODO: extract this into a function so it can be used for other paths (e.g. cdpath, manpath)
for dir in ${pathdirs}; do
	if [[ -d $dir ]]; then
		debug_log Adding $dir to path...
		path=( $path $dir ) 
	fi
done

# TODO: Fix this so we can move /bin lower in the path, not have to put /usr/local/bin in front
debug_log path now is: $path
debug_log About to add /usr/local/bin to front of path...
path=( /usr/local/bin $path )
debug_log /usr/local/bin should now be in front of path
debug_log path NOW is: $path

#
# CDPATH init
#
setopt autocd
cdpath=( ~ ~/Projects ~/dev/work ~/dev/projects ~/dev/external ~/dev/kits ~/dev ~/dev/work/rt )

# TODO: Add "shortcuts generator"? Or... just do it manually for my custom local shortcuts?


# 
# MANPATH init
#

# Allow MacPorts man pages and others
dirs=( /usr/local/git/man /sw/share/man /opt/local/man /usr/local/man ~/Docs/man)
for dir ($dirs) 
  if [[ -x $dir ]]; then 
    debug_log $dir to manpath... 
    manpath=($manpath $dir) 
  fi

# Add function paths
# funcdirs=( $HOME/.zsh/func /sw/share/zsh/ /sw/share/zsh/VCS_Info /sw/share/zsh/VCS_Info/Backends)
# I'm using a manually installed zsh 4.3.9

binary=$(which zsh)
install_path=$binary:h:h # Strip bin/zsh to find installation path.

funcdirs=( $HOME/homeconf/zsh-functions $install_path/share/zsh/4.3.9/functions)
for dir ($funcdirs) 
  if [[ -x $dir ]]; then 
    debug_log Adding $dir to fpath... 
    fpath=($fpath $dir) 
  fi

