#!/bin/bash

# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

function get_brightness {
    var=`brightlight -r -p`
    echo "${var##* }" | sed 's/[^0-9]*//g'
}

function send_notification {
    DIR=`dirname "$0"`
    brightness=`get_brightness`
    icon_name="${HOME}/Pictures/Important/icons/other/b.png"
    #bn=$(( (brightness + 5) / 5 ))
    #bar=$(seq -s "" $bn | sed 's/[0-9]//g')

    # Send the notification
    dunstify "Brightness: $brightness%" -h int:value:$brightness -i "$icon_name" -t 1000 --replace=555 -u critical
}

case $1 in
    up)
    	# Raise the brightness (+ 5%)
	    brightness=`get_brightness`
	    rem=$(( (brightness + 5) % 5 ))
	    inc=$(( 5 - rem ))
        brightness=$(( brightness + inc ))
        [[ $brightness -eq 0 ]] && brightness=1
	    brightlight -w $brightness -p  > /dev/null
	    send_notification
	;;
    down)
        # Lower the brightness (+ 5%)              
        brightness=`get_brightness`             
        rem=$(( (brightness - 5) % 5 ))         
        inc=$(( 5 + rem ))                                    
        brightness=$(( brightness - inc ))    
        [[ $brightness -eq 0 ]] && brightness=1    
	    brightlight -w $brightness -p  > /dev/null
	    send_notification
	;;
esac
