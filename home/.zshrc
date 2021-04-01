# Preload
# BUG: https://github.com/robbyrussell/oh-my-zsh/issues/2750
bindkey "\e$terminfo[kcub1]" backward-word
bindkey "\e$terminfo[kcuf1]" forward-word

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/voronwe/.oh-my-zsh"

# Rust default settings path
export RUSTUP_HOME=/home/voronwe/.config/rust

# Cookie file path for pulseaudio
export PULSE_COOKIE=~/.config/pulse/cookie

# Postgresql history file
export HISTFILE=~/.config/postgresql/.psql_history

# Envirable variables with secret data exports here
export $(xargs < $HOME/scripts/secret_envs)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"
# ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions)

# Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Store .zcompdump files in .cache insead of $HOME
# FIXME: this files occures both in $HOME and .cache now :(
# autoload  -Uz compinit
# compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# export MAKEFLAGS='-j 7'

# Default terminal
# export TERM='alacritty'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias l='ls -gho --color=tty'
alias k='ls -gho --color=tty'
alias д='ls -gho --color=tty'
alias л='ls -gho --color=tty'
alias ll='ls -l'
alias lst='ls -ghotr'

alias sd='sudo shutdown -h now'

alias up='
    pacget -Syu 
    rustup update
    git -C ~/.config/i3blocks pull --depth=1

    for dir in /home/voronwe/.vim/pack/plugins/start/*/
    do
	git -C $dir pull --depth=1
    done
    
    ~/projects/bash/config/backup.sh'

alias гз='up'

alias c='clear'
alias с='clear'

alias wtf='watch fping google.com'
alias цеа='watch fping google.com'

alias ports='sudo netstat -tulpn'

alias wget="wget --hsts-file ~/.config/wget"

#################################################
####################work#########################
#################################################

alias prod='psql -U $SECRET_USER_NAME -p $SECRET_GORDON_POSTGRES_PORT -h $SECRET_GORDON_POSTGRES_HOST --dbname=$SECRET_GORDON_DB_NAME'

#################################################
###################scripts#######################
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

####### vim with alacrity

# vim() {
#   if [ -n "${1}" ]; then
#     local target=$(realpath $1)
#   fi
# 
#   nohup alacritty \
# 	--config-file ~/.config/alacritty/alacritty-vim.yml \
# 	-t "${target}" \
# 	--option font.size=20 \
# 	-e $SHELL -lc "vim ${target}" >/dev/null &
# }

#################################################
###################trash#########################
#################################################

[[ -s "/home/voronwe/.gvm/scripts/gvm" ]] && source "/home/voronwe/.gvm/scripts/gvm"
source /usr/share/autoenv-git/activate.sh
