#!/usr/bin/env bash

# Source files for wpgtk colorscheme
source "${HOME}/.cache/wal/colors.sh" 

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Ignore dupplicate commands 
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# Add custom directories to PATH
export PATH=$PATH:/home/kz87/.ricing
export PATH=$PATH:/home/kz87/.bscripts
export PATH=$PATH:/home/kz87/.osuthings
export PATH=$PATH:/home/kz87/
export PATH=$PATH:/home/kz87/.is
export PATH=$PATH:/home/kz87/AppImages
export PATH=$PATH:/home/kz87/.bin
export PATH=$PATH:/home/kz87/.local/bin
export PATH=$PATH:/home/kz87/.cargo/bin
export PATH=$PATH:/home/kz87/.local/share/gem/ruby/3.0.0/bin

for sd_cmd in systemctl systemd-analyze systemd-run; do
  alias $sd_cmd='DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus" '$sd_cmd
done

# Define editor
export EDITOR=$EDITOR:nvim

# Color definitions
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
LBLUE='\033[1;34m'
YELLOW='\033[0;33m'
PURPLE='\033[0;36m'
ORANGE='\033[0;35m'
NC='\033[0m'

# Turn off beep sound from hell
xset b off
xset b 0 0 0

# Autocompletion
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind -f  ~/.inputrc

# Custom prompt
function set_prompt {
  code=$? 
  git_branch=`git branch --show-current 2> /dev/null`
  if [[ $code == 0 ]]
  then
    prompt_code='\[\e[0;32m\] '
  else
    prompt_code='\[\e[0;31m\]$code 𥉉' 
  fi;
  if [[ $git_branch != "" ]]
  then
    git_branch=" \[\e[1;34m\]$git_branch"
  fi;

  export PS1="$prompt_code\[\e[0;36m\][\[\e[0;00m\]kz87|bash\[\e[0;36m\]]\[\e[0;31m\]\w$git_branch: \[\e[0m\]"
}
PROMPT_COMMAND=set_prompt
#export PS1='\[\e[0;36m\][\[\e[0;00m\]kz87|bash\[\e[0;36m\]]\[\e[0;31m\]\w: \[\e[0m\]'

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# Auto login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec start 
else
  # Add image
  #icat --place 24x24@1x1 ~/.pfp.png
  echo ""
  chafa ~/.pfp.png -s 24x24 --polite true
  tput cup 0 0
  # Bash greeter
  macchina -o host -o kernel -o packages -o terminal -o uptime
  printf "${NC}おかえりなさい、 kz87-さま。\n"
fi

