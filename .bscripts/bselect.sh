#!/bin/sh

# Select window using cardinal directions in bspwm.
# This is an edited version of "bsmove.sh"
# credits can be found on that file.
# You can call this script like this:
# bselect.sh [north|east|south|west]

[ "$#" -eq 1 ] || { echo "Pass only one argument: north,east,south,west"; exit 1; }

# Check if argument is a valid direction.
case "$1" in
	north|east|south|west)
		dir="$1"
		;;
	*)
		echo "Not a valid argument."
		echo "Use one of: north,east,south,west"
		exit 1
		;;
esac

_query_nodes() {
	bspc query -N -n "$@"
}

# Do not operate on floating windows!
[ -z "$(_query_nodes focused.floating)" ] || { echo "Only move tiled windows."; exit 1; }

receptacle="$(_query_nodes 'any.leaf.!window')"

# This regulates the behaviour documented in the description.
if [ -n "$(_query_nodes "${dir}.!floating")" ]; then
	bspc node -f "$dir"
elif [ -n "$receptacle" ]; then
	bspc node -f "$receptacle"
else
	#bspc node @/ -p "$dir" -i && bspc node -n "$receptacle" --follow
	true
fi

