#!/bin/sh

# This script is used to run rofi with different configurations
# based on desired usage.
# You can call this script like this:
# rofi.sh [drun|config|window|outopts]

roficonf="$HOME/.config/rofi/"

case $1 in 
    drun)    
        rofi -config $roficonf/drun.rasi -show drun
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
                confirm=`printf "Confirm reboot" | rofi -config $roficonf/logout.rasi -dmenu -font "Iosevka Curly 16"`
            [[ $confirm == "Confirm reboot" ]] && reboot
            ;;
            "⏻")
                confirm=`printf "Confirm shut down" | rofi -config $roficonf/logout.rasi -dmenu -font "Iosevka Curly 16"`
                [[ $confirm == "Confirm shut down" ]] && shutdown now
            ;;
        esac
    ;;
esac
