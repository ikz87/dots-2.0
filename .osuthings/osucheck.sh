#!/bin/bash

inotifywait -m --format %f -e close_write -q "$1" | while read filename; do
	if [[ `echo $filename | grep .osz` ]]
	then
		echo New osz file detected
		xdotool search --class Surfdload windowclose
		if [[ `pgrep osu-stable -c` -gt 0 ]]
		then
			echo "osu is running, will open maps"
			osu-stable "$1"/*.osz&
		else
			echo "osu is not running, will only move files"
			mv "$1"/*.osz ~/osu/Songs
		fi;
		xdotool search --class Surfdload windowclose
	fi;
done
