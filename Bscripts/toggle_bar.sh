#!/bin/sh

# Toggles bar on and off.
# You can call this script like this:
# toggle_bar auto|on|off|test_fullscreen

auto(){
    (xdotool search --onlyvisible --class eww- || \
        xdotool search --onlyvisible --class Polybar)

    if [[ $? -eq 0 ]] 
    then
        off
    else
        on
    fi;
}

on(){
    bspc config top_padding 70
    for wid in `xdotool search --class eww-`; 
    do 
        xdotool windowmap --sync $wid
    done;
    xdotool search --class Polybar windowmap 
}

off(){
    bspc config top_padding 0
    for wid in `xdotool search --class eww-`; 
    do 
        xdotool windowunmap --sync $wid
    done;
    xdotool search --class Polybar windowunmap 
}
 
test_fullscreen(){
    if [[ -z "$(bspc query -N -n focused.fullscreen)" ]]
    then
        on
    else
        off
    fi;
}

$1
