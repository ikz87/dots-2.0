#!/bin/sh

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {

    DIR=`dirname "$0"`
    overvolume=`get_volume`
    [[ $overvolume -gt 100 ]] && volume=100 || volume=$overvolume
    #Set correct icon
    if [[ $volume -eq 0 ]]
        then
            icon_name="~/Pictures/Important/icons/other/nov.png"
        elif [[ $volume -lt 35 ]] 
        then
            icon_name="~/Pictures/Important/icons/other/vlow.png"
        elif [[ $volume -lt 70 ]]
        then 
            icon_name="~/Pictures/Important/icons/other/vmid.png"
        elif [[ $volume -lt 100 ]]
        then 
            icon_name="~/Pictures/Important/icons/other/vhigh.png"
        else
            icon_name="~/Pictures/Important/icons/other/vthigh.png"
    fi;
    bn=$(( (volume + 5) / 5 ))
                                                                                                                                                                    
  bar=$(seq -s "" $bn | sed 's/[0-9]//g')          
                                                                                                         
  # Send the notification                                                      
  $DIR/notify-send.sh "Volume: $overvolume%\n\n$bar" -i "$icon_name" -t 1000 --replace=555 -u critical


}

function filler {
    DIR=`dirname "$0"`
    overvolume=`get_volume`
    [[ $overvolume -gt 100 ]] && volume=100 || volume=$overvolume
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
#bar=$(seq -s "─" $(($volume/5)) | sed 's/[0-9]//g')
if [ "$volume" = "0" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-muted.svg"
$DIR/notify-send.sh "Volume: $overvolume%\n $bar" -i "$icon_name" -t 1000 --replace=555 -u critical
    else
	if [  "$volume" -lt "10" ]; then
	     icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
$DIR/notify-send.sh "$volume""     " -i "$icon_name" --replace=555 -t 2000
    else
        if [ "$volume" -lt "30" ]; then
            icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
        else
            if [ "$volume" -lt "70" ]; then
                icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-medium.svg"
            else
                icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-high.svg"
            fi
        fi
    fi
fi

bn=$(( (volume + 5) /5 ))
bar=$(seq -s "█" $bn | sed 's/[0-9]//g')


# Send the notification
$DIR/notify-send.sh "Volume: $overvolume%\n\n$bar" -i "$icon_name" -t 1000 --replace=555 -u critical

}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
    curvol=`amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 |     cut -d '%' -f 1`
    rem=$(( (curvol + 5) % 5 ))
    inc="+$(( 5 - rem ))%"
    pactl set-sink-volume @DEFAULT_SINK@ $inc > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
    curvol=`amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 |     cut -d '%' -f 1`
    rem=$(( (curvol - 5) % 5 ))
    inc="-$(( 5 + rem ))%"
	pactl set-sink-volume @DEFAULT_SINK@ $inc > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
    DIR=`dirname "$0"`
    $DIR/notify-send.sh -i "~/Pictures/Important/icons/other/mute.png" --replace=555 -u normal "Volume: Mute" -t 1000 -u critical
	else
	    send_notification
	fi
	;;
esac
#mpg123 ~/Pictures/Important/icons/other/laser.mp3
