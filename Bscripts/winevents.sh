#!/bin/sh
secondlast=""
lastline=""
bspc subscribe desktop_focus node_state node_add node_remove| \
    while read line; do
        echo $line
        case $line in
            node_add*)
                play -v 0.3 ~/.config/rice_assets/Sounds/add.wav 2> /dev/null&
                ~/.bscripts/toggle_bar.sh test_fullscreen
                ;;
            node_remove*)
                play -v 0.4 ~/.config/rice_assets/Sounds/remove.wav 2> /dev/null&
                ~/.bscripts/toggle_bar.sh test_fullscreen
                ;;
            *\ fullscreen\ on)
                play -v 0.4 ~/.config/rice_assets/Sounds/fullscreen.wav 2> /dev/null&
                ~/.bscripts/toggle_bar.sh off&
                ;;
            *\ fullscreen\ off)
                ~/.bscripts/toggle_bar.sh on&
                ;;
            *\ tiled\ on)
                play -v 0.4 ~/.config/rice_assets/Sounds/tile.wav 2> /dev/null& 
                ;;
            *\ floating\ on)
                play -v 0.4 ~/.config/rice_assets/Sounds/float.wav 2> /dev/null&
                ;;
            desktop_focus*)
                play -v 0.1 ~/.config/rice_assets/Sounds/change_workspace.wav 2> /dev/null&
                ~/.bscripts/toggle_bar.sh test_fullscreen
                ;;
            *)
                :
                ;;
        esac
        secondlast=$lastline
        lastline=$line 
    done

        

