#!/bin/bash

# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

function get_brightness {
    var=`light -G`
    echo "${var##* }" | sed 's/[^0-9][^.]*//g'
}

function send_notification {
    DIR=`dirname "$0"`
    brightness=`get_brightness`
    [[ $brightness == "0" ]] && brightness=0.1
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
        [[ $brightness -eq 0 ]] && brightness=1
	    light -S $brightness  > /dev/null
	    send_notification
	;;
    down)
        # Lower the brightness (- 5%)              
        brightness=`get_brightness`             
        rem=$(( (brightness - 5) % 5 ))         
        inc=$(( 5 + rem ))                                    
        brightness=$(( brightness - inc ))    
        [[ $brightness -eq 0 ]] && brightness=0.4
        light -S $brightness > /dev/null
	    send_notification
	;;
esac
