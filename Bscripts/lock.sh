#!/bin/sh

export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
xrandr --output "$PRIMARY_DISPLAY" --brightness 1
pkill -SIGUSR1 dunst # pause 
mantablockscreen -sc 2> /dev/null # requires https://github.com/reorr/mantablockscreen      
pkill -SIGUSR2 dunst # resume 
