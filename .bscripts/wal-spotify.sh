#!/bin/sh

# Sets spicetify colors to fit the colorscheme

source "${HOME}/.cache/wal/colors.sh"

spicetify color text "$color9" 
spicetify color subtext "$color15"
spicetify color button-text "$color15"
spicetify color main "$color0"
spicetify color sidebar "$color0"
spicetify color player "$color0"
spicetify color card "$color8"
spicetify color shadow "000000"
spicetify color selected-row "$color8"
spicetify color sub-button "000000"
spicetify color button "$color8"
spicetify color button-active "ffffff"
spicetify color button-disabled "$color8"
spicetify color sidebar-button "$color8"
spicetify color play-button "$color9"
spicetify color tab-active "$color8"
spicetify color misc "000000"
spicetify color playback-bar "$color9"
spicetify update
