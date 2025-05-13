#!/bin/sh
source ~/.cache/wal/colors.sh

# Glyphs
selected=""
wp=""
left=""
right=""


# Variables
total=`wmctrl -d | grep -v Desktop | wc -l`
current=`wmctrl -d | grep "*" | awk '{print $1}'`
duration=500
topic="workspace"
font_size="50px"
padding="."

function report_jump {
    echo -n "<span style=\"color: #00000000; font-size: $font_size\">$padding</span>"
    for (( i = 0; i < $total; i++)); do
        if [[ $i -eq $target ]]; then
            echo -n "<span style=\"font-size: $font_size; color: $color15 \">$selected</span>"
        else
            echo -n "<span style=\"font-size: $font_size; color: $color15 \">$wp</span>"
        fi;
        [[ $i < $(( total - 1 )) ]] && echo -n "<span style=\"color: #00000000; font-size: $font_size\">$right</span>"
    done
    echo -n "<span style=\"color: #00000000; font-size: $font_size\">$padding</span>"
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
    echo -n "<span style=\"color: #00000000; font-size: $font_size\">$padding</span>"

    for (( i = 0; i < $total; i++ )); do
        separator="<span style=\"color: #00000000; font-size: $font_size\">$main</span>"
        if [[ $i -eq $target ]]; then
            echo -n "<span style=\"font-size: $font_size; color: $color15 \">$selected</span>"
            [[ $main == $left ]] && separator="<span style=\"font-size: $font_size; color: $color9 \">$main</span>"

        else
            echo -n "<span style=\"font-size: $font_size; color: $color15\">$wp</span>"
        fi;
        [[ $main == $right ]] && [[ $((i + 1)) -eq $target ]] && separator="<span style=\"font-size: $font_size\">$main</span>"
        ([[ $((current - target)) -eq $((total - 1)) ]] || [[ $((target - current)) -eq $((total - 1)) ]]) && separator="<span style=\"font-size: $font_size\">$sec</span>"
        [[ $i -lt $((total - 1)) ]] && echo -n "<span style=\"font-size: $font_size; color: $color9\">$separator</span>"
    done            
    echo -n "<span style=\"color: #00000000; font-size: $font_size\">$padding</span>"
}

function bsmove {
	bspc node -d ^$(( target + 1 )) --follow || bselect
}

bselect()
{
    bspc desktop -f ^$(( target + 1 ))    
}

case $1 in
    jump)
        target=$2
        message=`report_jump`
        echo "$message"
        bselect
        ;;
    select)
        target=$(( current + $2 ))
        [[ $target -eq $(( -1 )) ]] && target=$(( total - 1 ))    
        [[ $target -eq $(( total )) ]] && target=0
        message=`report_move $2`
        echo "$message"
        bselect
        ;;
    move)
        currwin=`xdotool getwindowfocus`
        target=$(( current + $2 ))    
        [[ $target -eq $(( -1 )) ]] && target=$(( total - 1 ))        
        [[ $target -eq $(( total )) ]] && target=0    
        message=`report_move $2`    
        echo "$message"
        bsmove  
        ;;
esac;
notify-send "Workspace $(( target + 1 ))" "$message" -t $duration -h int:yawn_type:2 -r 87
