#
# ~/.bashrc
#

# autorun
export MAKEFLAGS='-j 7'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
export EDITOR="nano"

#expansions
alias l='ls -gho --color=tty'
alias k='ls -gho --color=tty'
alias д='ls -gho --color=tty'
alias л='ls -gho --color=tty'
alias ll='ls -l'

alias sd='sudo shutdown -h now'

alias up='pac -Syu && rustup update'
alias гз='pac -Syu && rustup update'

alias c='clear'
alias с='clear'
alias inet='sudo ip link set wlp3s0 down && sudo ip link set wlp3s0 up && sudo systemctl restart wicd'

alias wtf='ping ya.ru'
alias цеа='ping ya.ru'

# moves
alias v2='cd ~/work/environment_root/server/v2'
alias v5='cd ~/work/environment_root/server/v2'


#################################################
##################work###########################
#################################################

alias build='cd ~/work/environment_root/server/v2 && node node_modules/.bin/gulp build'
alias dev='cd ~/work/environment_root/server/v2 && node node_modules/.bin/gulp dev'
#alias autogen='cd ~/work/environment_root/server/v2 && node node_modules/.bin/gulp jison'
alias nodedb='node --inspect --debug-brk'
alias gulp='~/work/environment_root/server/v2/node_modules/.bin/gulp'
alias gulpall='cd ~/work/environment_root/server/v2 && gulp dev && gulp dev --spa static && gulp dev --spa site'

rewind_v5_database() {
  cd ~/work/environment_root/server/v5 || exit

  db_exists=$(test -e ./visyond/db.sqlite3)
  if [ "$db_exists" != 0 ]; then
    rm visyond/db.sqlite3
  fi

  rm -r visyond/storage/*

  ./manage.sh migrate
  ./manage.sh bootstrap --develop
}

unittest () {
  cd ~/work/environment_root/server/v2 || exit
  arg="all"
  if [ ! -z "$1" ]; then
    arg=$1
  fi

  node node_modules/.bin/gulp test -u --test "$arg" -j7
}

performtest () {
  cd ~/work/new/environment_root/server/v2 || exit
  node node_modules/.bin/gulp test --unit --expose performance/"$1"

}


#################################################
################scripts##########################
#################################################

####### archives

unpack () {
  if [ -f "$1" ]; then
    case $1 in
      *.tar.bz2)   tar xvjf "$1"    ;;
      *.tar.gz)    tar xvzf "$1"    ;;
      *.tar.xz)    tar xvJf "$1"    ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xvf "$1"     ;;
      *.tbz2)      tar xvjf "$1"    ;;
      *.tgz)       tar xvzf "$1"    ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *.xz)        unxz "$1"        ;;
      *.exe)       cabextract "$1"  ;;
      *)           echo "\`$1': Unknown method of file compression" ;;
    esac
  else
    echo "\`$1' no found"
  fi
}


####### git

function git-current-branch {
    git branch --no-color 2> /dev/null | grep \* | colrm 1 2
}

function last_two_dirs {
    pwd |rev| awk -F / '{print $1,$2}' | rev | sed s_\ _/_
}

function set_prompt_line {
    local        BLUE="\[\033[0;34m\]"

    # OPTIONAL - if you want to use any of these other colors:
    local         RED="\[\033[0;31m\]"
    local   LIGHT_RED="\[\033[1;31m\]"
    local       GREEN="\[\033[0;32m\]"
    local LIGHT_GREEN="\[\033[1;32m\]"
    local       WHITE="\[\033[1;37m\]"
    local  LIGHT_GRAY="\[\033[0;37m\]"
    # END OPTIONAL
    local     DEFAULT="\[\033[0m\]"
    export PS1="$GREEN\$(last_two_dirs) $LIGHT_GREEN[\$(git-current-branch)]$DEFAULT\$ "
}

# set_prompt_line

# LFS
export LFS=/mnt/lfs

# exonium
# export ROCKSDB_LIB_DIR=/usr/lib/x86_64-linux-gnu
# export SNAPPY_LIB_DIR=/usr/lib/x86_64-linux-gnu

# xmonad unfreez
function unstuck {
  pid=$(pgrep xmonad)
  cat /proc/$pid/fd/4
}
# source /usr/share/undistract-me/long-running.bash
# notify_when_long_running_commands_finish_install
