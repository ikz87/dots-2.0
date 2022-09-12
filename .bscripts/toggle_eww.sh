#!/bin/sh

eww="eww -c ${HOME}/.config/eww/mybar/"

$eww close bar_center

if [[ $? -eq 0 ]] 
then
    $eww close-all
    killall polybar
    bspc config top_padding 0
    echo "eww off"
else
    $eww open-many bar_left bar_center bar_right
    polybar -c ~/.config/eww/mybar/polybar_tray.ini& > /dev/null
    bspc config top_padding 70
    echo "eww on"
fi;

