#!/bin/bash

# You can call this script like this:
# $./gamma.sh up
# $./gamma.sh down
gamma_file="/tmp/gamma"

function get_gamma {
    cat $gamma_file || echo 1
}

function send_notification {
    gamma=`get_gamma`
    gamma=`echo $gamma | awk '{printf $1*100}'`
    icon_name="${HOME}/.config/rice_assets/Icons/gamma.png"

    # Send the notification
    dunstify "Gamma: $gamma%" -h int:value:$gamma -i "$icon_name" -t 1000 --replace=555 -u critical
}

case $1 in
    up)
    	# Raise the gamma (+ 5%)
	    gamma=`get_gamma`
        gamma=`echo $gamma | awk '{printf $1*100}'`
	    rem=$(( (gamma + 5) % 5 ))
	    inc=$(( 5 - rem ))
        gamma=$(( gamma + inc ))
        [[ $gamma -eq 0 ]] && gamma=1
        gamma=`echo $gamma | awk '{printf $1/100}'`
        xrandr --output eDP-1 --gamma $gamma && echo $gamma > $gamma_file
	    send_notification
	;;
    down)
        # Lower the gamma (- 5%)              
        gamma=`get_gamma`             
        gamma=`echo $gamma | awk '{printf $1*100}'`
        rem=$(( (gamma - 5) % 5 ))         
        inc=$(( 5 + rem ))                                    
        gamma=$(( gamma - inc ))    
        [[ $gamma -eq 0 ]] && gamma=1    
        gamma=`echo $gamma | awk '{printf $1/100}'`
        xrandr --output eDP-1 --gamma $gamma && echo $gamma > $gamma_file

	    send_notification
	;;
esac
