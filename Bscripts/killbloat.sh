#!/usr/bin/env bash

bspc config top_padding 0

killall picom
pkill osucheck
killall inotifywait
killall workspaces
killall media_info
killall layout
#killall polybar
killall eww
killall blueman-applet
killall pa-applet
killall nm-applet
killall flameshot
killall winevents.sh

notify-send "Killed all bloat, ready to game"
