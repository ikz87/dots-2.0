#!/bin/bash

# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down
command="backlight_control"

function get_brightness {
    cat /sys/class/backlight/amdgpu_bl2/actual_brightness | awk '{printf "%.f\n", $1/2.55}'
}

function send_notification {
    DIR=`dirname "$0"`
    brightness=`get_brightness`
    icon_name="${HOME}/.config/rice_assets/Icons/b.png"

    # Send the notification
    notify-send "Brightness
$brightness%" -h int:value:$brightness -h int:yawn_type:2 -i "$icon_name" -t 1000 -r 555 -u critical
}

case $1 in
    up)
    	# Raise the brightness (+ 5%)
	    brightness=`get_brightness`
	    rem=$(( (brightness + 5) % 5 ))
	    inc=$(( 5 - rem ))
        brightness=$(( brightness + inc ))
	    backlight_control $brightness  > /dev/null
	    send_notification
	;;
    down)
        # Lower the brightness (- 5%)              
        brightness=`get_brightness`             
        rem=$(( (brightness - 5) % 5 ))         
        inc=$(( 5 + rem ))                                    
        brightness=$(( brightness - inc ))    
        backlight_control $brightness > /dev/null
	    send_notification
	;;
esac
