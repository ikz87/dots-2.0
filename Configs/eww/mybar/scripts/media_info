#!/bin/sh

# Selects player based on if they're playing or if they have a cover
# Note: Being played takes priority
select_player () {
	playingplayer=""
	coverplayer=""
	totalplayer=""
	playerctl -l 2> /dev/null | while read -r player;
	do
		art=`playerctl --player="$player" metadata mpris:artUrl 2> /dev/null`
		status=`playerctl --player="$player" status 2> /dev/null`
		[[ $status == "Playing" ]] && playingplayer="$player"
		[[ $art != "" ]] && coverplayer="$player"
		[[ $status == "Playing" && $art != "" ]] && totalplayer="$player"
		[[ ! -z $coverplayer ]] && player="$coverplayer"
		[[ ! -z $playingplayer ]] && player="$playingplayer"
		[[ ! -z $totalplayer ]] && player="$totalplayer"
		echo "$player"
	done;
}	

update_cover () {
	if [[ -z $newimg ]] 
    then
		newimg="$imgdir/music.png"
		cp "$newimg" "$imgdir/currmedia.png"
		rm "$imgdir/currmedia_fullsize"
		echo "Image is unknown, using template"
	elif [[ `echo $newimg | grep -c "file://"` -gt 0 ]]
	then
		cp "`echo $newimg | sed 's/file:\/\///g'`" "$imgdir/currmedia_fullsize.png"
		convert "$imgdir/currmedia_fullsize.png" -resize 130x130 "$imgdir/currmedia.png"
		echo "Image is a file, succesfully copied"
	else
		echo "Image is an url, trying to download..."
		curl "$newimg" -o "/tmp/currmedia.png" -s --max-time 5
		if [[ $? -eq 0 ]]
		then
			cp "/tmp/currmedia.png" "$imgdir/currmedia_fullsize.png"
			convert "/tmp/currmedia.png" -resize 130x130 "$imgdir/currmedia.png"
			#cp /tmp/currmedia.png "$imgdir/currmedia.png"
			echo "Image succesfully downloaded"
		else
			cp "$imgdir/music.png" "$imgdir/currmedia.png"
			rm "$imgdir/currmedia_fullsize"
			echo "Failed to download image, using template"
		fi;
	fi;
	$eww update cover="$imgdir/currmedia.png"
}

scroll_text () {
	scroll_index=0
	text=$1
	text_len=$2
	eww_var=$3
	$eww update $eww_var="$text"
	while true; do
		text_parsed=`$HOME/.config/eww/mybar/scripts/parse_jp "$text" "$scroll_index"`
		scroll_index=$(( (scroll_index + 1) % (text_len + 8) )) 
		$eww update $eww_var\_parsed="$text_parsed"
		# Change the value below to control how fast text should scroll
		sleep 0.3
	done
}

imgdir="$HOME/.config/eww/mybar/images"
lastimg="none"
eww="eww -c $HOME/.config/eww/mybar"

while true; do
	if [[ ! -z `playerctl status 2> /dev/null` ]]
	then
		player=`select_player 2> /dev/null | tail -1`
		status=""
		status=`playerctl --player="$player" status 2> /dev/null`
		#echo "Selected $player as player"

		# Update status button
		if [[ $status == "Playing" ]]
		then
			$eww update media_status=""
		else
			$eww update media_status=""
		fi;
		
		# Update title and artist
		last_title="$title"
		title=`playerctl --player="$player" metadata xesam:title 2> /dev/null`
		[[ -z $title ]] && title="No title"
		if [[ "$title" != "$last_title" ]]
		then
			jobs -l | grep "scroll_text \"\$title\"" | while read line; do
				title_job_pid=`echo $line | awk '{printf$2}'`
				echo $title_job_pid
				kill $title_job_pid 2> /dev/null && echo "killed job at $title_job_pid"
			done;

			title_len=${#title}
			if [[ $title_len -gt 20 ]] 
			then
				echo "Started a text scroll job for title" 
				scroll_text "$title" "$title_len" "title" &
			else
				title_parsed=`$HOME/.config/eww/mybar/scripts/parse_jp "$title" "0"`
				$eww update title="$title"
				$eww update title_parsed="$title_parsed"
			fi;
		fi;

		last_artist="$artist"
		artist=`playerctl --player="$player" metadata xesam:artist 2> /dev/null`
		[[ -z $artist ]] && artist="No artist"
		if [[ "$artist" != "$last_artist" ]]
		then
			jobs -l | grep "scroll_text \"\$artist\"" | while read line; do
				artist_job_pid=`echo $line | awk '{printf$2}'`
				kill $artist_job_pid 2> /dev/null && echo "killed job at $artist_job_pid"
			done;

			artist_len=${#artist}
			if [[ $artist_len -gt 21 ]] 
			then
				echo "Started a text scroll job for artist" 
				scroll_text "$artist" "$artist_len" "artist" &
			else
				artist_parsed=`$HOME/.config/eww/mybar/scripts/parse_jp "$artist" "0"`
				$eww update artist="$artist"
				$eww update artist_parsed="$artist_parsed"
			fi;
		fi;

		# Update length and position
		position=`playerctl --player="$player" position 2> /dev/null`
		[[ -z $position ]] && position=0
		$eww update position="$position"
		length=`playerctl --player="$player" metadata mpris:length 2> /dev/null`
		[[ -z $length ]] && length=100 || length=`python -c "print($length/1000000)"`
		$eww update length="$length"

		newimg=`playerctl --player="$player" metadata mpris:artUrl 2> /dev/null\
                | sed "s/https:\/\/i.ytimg.com\/vi\//https:\/\/img.youtube.com\/vi\//g"\
                | sed "s/hq/maxres/g"`

	   if [[ "$newimg" != "$lastimg" ]]
	   then
	       echo "New image $newimg detected"
	       lastimg=$newimg
			update_cover&
        fi;
	else
		jobs -p | while read pid; do
			kill $pid 2> /dev/null && echo "killed job at $pid"
			done;
		# Update everything to default values
		$eww update media_status=""
		$eww update title_parsed="No title"
		$eww update title="No title"
		$eww update artist="No artist"
		$eww update artist_parsed="No artist"
		$eww update position=0
		$eww update length=100
		$eww update cover="images/music.png"
		lastimg=""
	fi;
	sleep 1
done;	
