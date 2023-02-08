#!/bin/sh

# This script locks the PC after a <normal_time> amount of "idle" seconds
# When unlocked, idle time is considered as time where no cursor movement
# or any X input (anything that xev can notice) is detected *and* no audio
# is being played. This makes it so that the PC doesn't lock while you game
# even when gamepad activity is generally not detected by X.
# When screen is locked, only X activity is considered for idle time, and 
# the PC will suspend after <locked_time> seconds.

locked_time=10
normal_time=900

locked_ms=$(( locked_time * 1000 ))
normal_ms=$(( normal_time * 1000 ))

idle=0
lastsi=0

[[ `pgrep -c idle.sh` -gt 1 ]] && exit

while true;
do
	[[ `pgrep -c Xorg` -gt 0 ]] && true || exit 
	while [[ `ps -e | grep -c i3lock` -gt 0 ]];
		do
			[[ `xprintidle` -gt $locked_ms ]] && systemctl suspend && sleep $locked_time
			sleep 1
		done;
	idle=`xprintidle` 		
	[[ `pactl list short sinks | grep -c 'RUNNING'` -gt 0 ]] && lastsi=$idle && echo running
	[[ $idle -lt 1000 ]] && lastsi=0
	ridle=$(( idle - lastsi ))	
	if [[ $ridle -gt $normal_ms ]]
	then
		~/.bscripts/lock.sh&
	fi;
	sleep 1
done;

