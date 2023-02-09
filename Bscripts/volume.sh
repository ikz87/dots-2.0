#!/bin/sh

# Changes de volume of the default sink
# Warning: This script offers no cap for volume, 
# I'd advice to not go above 150% (which is the standard cap).
# You can call this script like this:
# volume.sh [up|down|mute]

function get_volume {
	pactl get-sink-volume @DEFAULT_SINK@ | awk '{printf $5}' | cut -d '%' -f 1
}

function is_mute {
	pactl get-sink-mute @DEFAULT_SINK@
}

function send_notification {

    overvolume=`get_volume`
    [[ $overvolume -gt 100 ]] && volume=100 || volume=$overvolume
    #Set correct icon
    if [[ $volume -eq 0 ]]
        then
            icon_name="${HOME}/.config/rice_assets/Icons/nov.png"
        elif [[ $volume -lt 35 ]] 
        then
            icon_name="${HOME}/.config/rice_assets/Icons/vlow.png"
        elif [[ $volume -lt 70 ]]
        then 
            icon_name="${HOME}/.config/rice_assets/Icons/vmid.png"
        elif [[ $volume -lt 100 ]]
        then 
            icon_name="${HOME}/.config/rice_assets/Icons/vhigh.png"
        else
            icon_name="${HOME}/.config/rice_assets/Icons/vthigh.png"
    fi;
    #bn=$(( (volume + 5) / 5 ))
                                                                                                                                                                    
    #bar=$(seq -s "" $bn | sed 's/[0-9]//g')          
                                                                                                         
    # Send the notification                                                      
    dunstify "Volume: $overvolume%" -h int:value:$volume -i "$icon_name" -t 1000 --replace=555 -u critical
}

case $1 in
    up)
	    # Set the volume on (if it was muted)
	    pactl set-sink-mute @DEFAULT_SINK@ 0 > /dev/null
	    # Up the volume (+ 5%)
    	curvol=`get_volume`
    	rem=$(( (curvol + 5) % 5 ))
    	inc="+$(( 5 - rem ))%"
    	pactl set-sink-volume @DEFAULT_SINK@ $inc > /dev/null
	    send_notification
	;;
    down)
	    pactl set-sink-mute @DEFAULT_SINK@ 0 > /dev/null
	    curvol=`get_volume`
    	rem=$(( (curvol - 5) % 5 ))
    	inc="-$(( 5 + rem ))%"
	    pactl set-sink-volume @DEFAULT_SINK@ $inc > /dev/null
	    send_notification
	;;
    mute)
    	# Toggle mute
	    pactl set-sink-mute @DEFAULT_SINK@ toggle > /dev/null
	    if [[ `is_mute` == "Mute: yes" ]] ; then
    		dunstify -i "${HOME}/.config/rice_assets/Icons/mute.png" --replace=555 -u normal "Volume: Mute" -t 1000 -u critical
	    else
	    	send_notification
	    fi
	;;
esac
