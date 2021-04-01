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

alias up='pac -Syu && pushd ~/.config/i3blocks && git pull && popd'
alias гз='pac -Syu && pushd ~/.config/i3blocks && git pull && popd'

alias c='clear'
alias с='clear'

alias wtf='watch fping google.com'
alias цеа='watch fping google.com'

alias ports='sudo netstat -tulpn'

#################################################
##################work###########################
#################################################

alias to-review="python ~/scripts/to-review.py"


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

set_prompt_line
alias webadmin='PYTHONPATH=/www/da/python:/www/da/python/webadmin DJANGO_SETTINGS_MODULE=settings.development django-admin.py'

# PATH
export PATH=$PATH:/home/$USER/.local/bin

[[ -s "/home/voronwe/.gvm/scripts/gvm" ]] && source "/home/voronwe/.gvm/scripts/gvm"
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
