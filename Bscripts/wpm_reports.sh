#!/bin/sh

# Glyphs
selected=""
wp=""
left=""
right=""


# Variables
total=`xdotool get_num_desktops`
current=`xdotool get_desktop`
duration=1000
font_size=90
topic="workspace"
separator_size="+0"
space_size="+0"

function report_jump {
    for (( i = 0; i < $total; i++)); do
        if [[ $i -eq $target ]]; then
            echo -n $selected
        else
            echo -n $wp
        fi;
        [[ $i < $(( total - 1 )) ]] && echo -n "<span style=\"color: #00000000\"><font size=\"$space_size\">$right</font></span>"
    done
}

function report_move {
    if [[ $1 -gt 0 ]]
    then
        main=$right
        sec=$left
    else
        main=$left
        sec=$right
    fi;

    for (( i = 0; i < $total; i++ )); do
        separator="<span style=\"color: #00000000\"><font size=\"$space_size\">$main</font></span>"
        if [[ $i -eq $target ]]; then
            echo -n $selected 
            [[ $main == $left ]] && separator="<font size=\"$separator_size\">$main</font>"
        else
            echo -n $wp
        fi;
        [[ $main == $right ]] && [[ $((i + 1)) -eq $target ]] && separator="<font size=\"$separator_size\">$main</font>"
        ([[ $((current - target)) -eq $((total - 1)) ]] || [[ $((target - current)) -eq $((total - 1)) ]]) && separator="<font size=\"$separator_size\">$sec</font>"
        [[ $i -lt $((total - 1)) ]] && echo -n "$separator"
    done            
}

function bsmove {
#    # Exit if last move hasn't finished
#	`cat /tmp/moving` && exit 1
#	
#	# Register move
#	echo true > /tmp/moving
#
#	# Get current window state 
#	for i in tiled pseudo_tiled floating fullscreen; 
#	do
#	     if [ -z "$(bspc query -N -n focused.$i)" ]
#	    then
#	        true
#	    else
#	        currstate=$i && break
#	    fi;
#    done
#
#	# Get window ID and geometry
#    currwin=`xdotool getwindowfocus`
#    geometry=`xwinfo -g $currwin`
#    width=`echo $geometry | awk '{printf $1}'`
#    height=`echo $geometry | awk '{printf $2}'`
#    xpos=`echo $geometry | awk '{printf $3}'`
#    ypos=`echo $geometry | awk '{printf $4}'`
#    
#    if [[ $currstate != "fullscreen" ]]
#    then
#        # Put window in floating mode
#        bspc node focused -t floating; xdotool windowsize $currwin $width $height; xdotool windowmove $currwin $xpos $(( ypos + 100))
#	
#    fi;
#	# Set it to be sticky
#    bspc node focused -g sticky=on -l above;
    # Move the window
	bspc node -d ^$(( target + 1 )) --follow
#	
#	# Reset state and flag accordingly
#	bspc node focused -t $currstate;
#	bspc node focused -g sticky=off -l normal;
#    xdotool windowmove $currwin $xpos $ypos
#	
#	echo false > /tmp/moving 
}

bselect()
{
    # Exit if last move hasn't finished    
#    `cat /tmp/moving` && exit 1    
#
#    # Set it to be sticky    
    bspc desktop -f ^$(( target + 1 ))    
#
#    # Register move    
#    echo true > /tmp/moving    
#
#    # Get current window state     
#    for i in tiled pseudo_tiled floating fullscreen;     
#    do  
#        if [[ `bspc query -N -n focused.$i` == "" ]]    
#        then    
#            true
#        else    
#            currstate=$i && break    
#        fi;    
#    done
#
#    # Get window ID and geometry
#    currwin=`xdotool getwindowfocus`
#    geometry=`xwinfo -g $currwin`
#    width=`echo $geometry | awk '{printf $1}'`
#    height=`echo $geometry | awk '{printf $2}'`
#    xpos=`echo $geometry | awk '{printf $3}'`
#    ypos=`echo $geometry | awk '{printf $4}'`
#    if [[ currstate != "fullscreen" ]] 
#    then
#        # Put window in floating mode    
#        bspc node focused -t floating; xdotool windowsize $currwin $width $height; xdotool windowmove $currwin $xpos $(( ypos + 100 ))
#        # Reset state and flag accordingly    
#        xdotool windowmove $currwin $xpos $ypos
#        bspc node focused -t $currstate 
#    fi;
#        
#    echo false > /tmp/moving 
}

case $1 in
    jump)
        target=$2
        message=`report_jump`
        pop_report -m "$message" -d $duration -t $topic -o\
            "font-size: $font_size\px"\
            "padding: 0"\
            "padding-bottom: 5px"\
            "padding-right: 40px"\
            "padding-left: 40px"&
        bselect
        ;;
    select)
        target=$(( current + $2 ))
        [[ $target -eq $(( -1 )) ]] && target=$(( total - 1 ))    
        [[ $target -eq $(( total )) ]] && target=0
        message=`report_move $2`
        pop_report -m "$message" -d $duration -t $topic -o\
            "font-size: $font_size\px"\
            "padding: 0"\
            "padding-bottom: 5px"\
            "padding-right: 43px"\
            "padding-left: 40px"&
        bselect
        #wmctrl -s $target    
        ;;
    move)
        currwin=`xdotool getwindowfocus`
        target=$(( current + $2 ))    
        [[ $target -eq $(( -1 )) ]] && target=$(( total - 1 ))        
        [[ $target -eq $(( total )) ]] && target=0    
        message=`report_move $2`    
        pop_report -m "$message" -d $duration -t $topic -o\
            "font-size: $font_size\px"\
            "padding: 0"\
            "padding-bottom: 5px"\
            "padding-right: 40px"\
            "padding-left: 40px"&
        bsmove  
        ;;
esac;

