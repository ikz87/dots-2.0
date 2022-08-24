#!/bin/sh

# A more fluid way of moving windows with BSPWM, which is meant to be
# implemented in SXHKD.  If there is a window in the given direction,
# swap places with it.  Else if there is a receptacle move to it
# ("consume" its place).  Otherwise create a receptacle in the given
# direction by splitting the entire viewport (circumvents the tiling
# scheme while respecting the current split ratio configuration).  In
# the latter scenario, inputting the direction twice will thus move the
# focused window out of its current layout and into the receptacle.
#
# Part of my dotfiles: https://gitlab.com/protesilaos/dotfiles
#
# Copyright (c) 2019 Protesilaos Stavrou <info@protesilaos.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


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
	bspc node -s "$dir"
elif [ -n "$receptacle" ]; then
	bspc node focused -n "$receptacle" --follow
else
	#bspc node @/ -p "$dir" -i && bspc node -n "$receptacle" --follow
	true
fi

