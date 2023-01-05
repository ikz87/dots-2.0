#!/usr/bin/env bash

# Source files for wlgtk colorscheme
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

for sd_cmd in systemctl systemd-analyze systemd-run; do
  alias $sd_cmd='DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus" '$sd_cmd
done

# Define editor
export EDITOR=$EDITOR:nvim

# Color definitions
RED='\033[0;31m'
LBLUE='\033[1;34m'
YELLOW='\033[0;33m'
PURPLE='\033[0;36m'
ORANGE='\033[0;35m'
NC='\033[0m'

# Turn off beep sound from hell
xset b off
xset b 0 0 0

# Custom prompt
export PS1='\[\e[0;36m\][\[\e[0;00m\]kz87|bash\[\e[0;36m\]]\[\e[0;31m\]\w: \[\e[0m\]'

# Bash greeter
macchina -o Host Kernel Packages Terminal Uptime Resolution
printf "${NC}おかえりなさい、 kz87-さま。\n"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
