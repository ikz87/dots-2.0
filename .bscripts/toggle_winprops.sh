#!/bin/sh

# Toggles window stuff
# You can call this script like this:
# toggle_winprops.sh float|fullscreen|layer

float() {
    if [[ -z "$(bspc query -N -n focused.floating)" ]]
    then
        currwin=`xdotool getwindowfocus`; 
        bspc node focused -t floating;     
        xres=`xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1`
        geometry=`xwinfo -g $currwin`; 
        width=`echo $geometry | awk '{printf $1}'`; 
        xpos=`echo $geometry | awk '{printf $3}'`; 
        ypos=70
        xdotool windowmove $currwin x $(( ypos + 100 ));
        xdotool windowmove $currwin $(( (xres - width) / 2 - 5 )) $ypos
    else 
        bspc node focused -t tiled;
    fi;    
}

fullscreen() {
    if [[ -z "$(bspc query -N -n focused.fullscreen)" ]]
    then
        bspc node focused -t fullscreen;
#        for wid in `xdotool search --class eww-`; 
#        do 
#            xdotool windowunmap --sync $wid
#        done;
#        xdotool search --class Polybar windowunmap 
    else
        bspc node focused -t tiled;
#       xdotool search --class Polybar windowmap --sync
#        for wid in `xdotool search --class eww-`; 
#        do 
#            xdotool windowmap --sync $wid
#        done;
#        xdotool search --class Polybar windowmap --sync
#        This is now handled in winevents.sh
    fi;
}

layer() {
    if [[ ! -z "$(bspc query -N -n focused.normal)" ]]
    then
        bspc node focused -l above
    elif [[ ! -z "$(bspc query -N -n focused.above)" ]]
    then    
        bspc node focused -l below
    else
        bspc node focused -l normal
    fi;
}

$1


