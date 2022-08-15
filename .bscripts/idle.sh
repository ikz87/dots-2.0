#!/bin/bash

time=900000
#time= 10000
idle=0
lastsi=0

[[ `pgrep -c idle.sh` -gt 1 ]] && exit

while true;
do
	[[ `pgrep -c Xorg` -gt 0 ]] && true || exit 
	while [[ `ps -e | grep -c i3lock` -gt 0 ]];
		do
			[[ `xprintidle` -gt 5000 ]] && systemctl suspend 
			sleep 1
		done;
	idle=`xprintidle` 		
	[[ `pacmd list-sink-inputs | grep -c 'state: RUNNING'` -gt 0 ]] && lastsi=$idle
	[[ $idle -lt 1000 ]] && lastsi=0
	printf "idle is $idle and lastsi is $lastsi, so ridle is "
	ridle=$(( idle - lastsi ))	
	echo $ridle
	if [[ $ridle -gt $time ]]
	then
		~/.bscripts/lock.sh&
	fi;
	sleep 1
done;

