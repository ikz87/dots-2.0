#!/bin/sh
source "${HOME}/.cache/wal/colors.sh" 
roficonf="$HOME/.config/rofi/"
color0=\#$alpha`echo $color0 | sed 's/\#//g'`

case $1 in 
    drun)    
        rofi -config $roficonf/drun.rasi -show drun
    ;;
    config)
        program=`cat ~/.config/programlist | \
        rofi -config $roficonf/drun.rasi -dmenu -no-show-icons  -p "Configure"`
        kitty config $program 
    ;;
    window)
        (rofi -config $roficonf/window.rasi -show windowcd; xdotool keyup Tab)&
        xdotool keyup Tab
        xdotool keydown Tab
    ;;
    outopts)
        option=`printf "\n\n\n⏻\n" | \
        rofi -config $roficonf/logout.rasi -dmenu -p "Select logout" -font "Caskaydia Cove Nerd Font 18"`
        case $option in
            "")
                bspc wm -r
            ;;
            "")
                ~/.config/bspwm/quit.sh
            ;;
            "")
                confirm=`printf "Confirm reboot" | rofi -config $roficonf/logout.rasi -dmenu -font "Nova Mono 15"`
            [[ $confirm == "Confirm reboot" ]] && reboot
            ;;
            "⏻")
                confirm=`printf "Confirm shut down" | rofi -config $roficonf/logout.rasi -dmenu -font "Nova Mono 15"`
                [[ $confirm == "Confirm shut down" ]] && shutdown now
            ;;
        esac
    ;;
esac
