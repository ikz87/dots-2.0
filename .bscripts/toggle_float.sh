if [ -z "$(bspc query -N -n focused.floating)" ];
then
    #play -v 0.2 ~/Documents/Sounds/float.wav& 
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
    #play -v 0.3 ~/Documents/Sounds/tile.wav&
    bspc node focused -t tiled ; \
    true
fi;    
