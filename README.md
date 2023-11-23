# dots-2.0

## An updated, revised version of my dotfiles 

Dotfiles for this [post](https://www.reddit.com/r/unixporn/comments/wosl44/bspwm_decided_to_finally_learn_how_to_use_eww/).

<p align="center">
  <img src="https://user-images.githubusercontent.com/98569017/219496787-6d14d6a3-77ed-4f01-a8e3-433e3e80c0ab.png" width=49%>
  <img src="https://user-images.githubusercontent.com/98569017/219498744-971e60ad-af74-427b-be08-1623c4e3bb2d.png" width=49%>
</p>

<p align="center">
<img src="https://user-images.githubusercontent.com/98569017/219504476-708ef653-1a1b-40de-ba00-3bdbf7b30c0f.gif" width=100%> 
</p>

I started using eww as a bar so I wrote everything from scratch and took the opportunity to be more organized.

For the wallpaper dependent colorschemes use: `.bscripts/wallset <path to wallpaper>`.

The profile picture shown in the lockscreen can be changed by putting the desired image in `~/.face`.

Please note that this rice was made for a single 1920x1080 monitor setup, If you have anything different than that you'll have to tweak some things on your own.

~~The picom fork used for animations might be a little unstable~~ (shouldn't be anymore). For any graphical glitches you may be having, toggle it off and on again with `super+p`.

## Dependency list:
### AUR packages
Just run this for this section (assuming you use yay):
```
yay -Sy acpi alsa-utils-git blueman brave-bin bspwm colorpicker dunst eww-git flameshot hsetroot imagemagick jq kitty light lxappearance mantablockscreen network-manager-applet pa-applet-git picom-ftlabs-git playerctl polkit-gnome polybar pqiv pulseaudio python3 rofi scrot sox spicetify-cli spotify sxhkd sysstat thunar tumbler ttc-iosevka-curly ttf-hack wmctrl wpgtk-git xclip xdotool xprintidle xorg xorg-xinit xorg-xwininfo --needed
```
If you're not using arch, this is the dependency list, install in wathever way you want:
- acpi
- alsa-utils
- blueman
- brave
- bspwm
- colorpicker
- dunst
- eww
- flameshot
- hsetroot
- imagemagick
- jq
- kitty
- light
- lm_sensors
- lxappearance
- mantablockscreen
- network-manager-applet
- pa-applet
- picom-ftlabs
- playerctl
- polkit-gnome
- polybar
- pqiv
- pulseaudio
- python3
- rofi
- scrot 
- sox 
- spicetify-cli
- spotify
- sxhkd
- sysstat
- thunar
- tumbler
- ttc-iosevka-curly
- ttf-hack
- wmctrl
- wpgtk
- xclip
- xdotool
- xprintidle
- xorg 
- xorg-xinit
- xwininfo

### Other 
- [pop_report](https://github.com/ikz87/pop_report) used in some scripts.

### Optional
- Plasma-integration [AUR package](https://aur.archlinux.org/packages/plasma-integration-git) and [chrome extension](https://chrome.google.com/webstore/detail/plasma-integration/cimiefiiaegbelhefglklhhakcgmhkai/related?hl=es) to better integrate media playing in brave with widgets (like having thumbnails of youtube videos show up in the left bar).


Please let me know if any packages are still missing.

## Installing
Install process functions a little different since I refactored the whole repo, but it still includes a handy script that automates most things.

Run install.sh:
``` 
chmod +x install.sh
./install.sh
```
*Disclaimer: While this script does attempt to create a backup of all files that will be rewritten and asks what to do when a backup already exists, I do not take responsibility for any lost config files as consequence of running this script. You are strongly advised to read the insides of the script before running.*

The install script should do the following changes to your files:
1. Move every file/folder that will be changed to `~/.rice-old` in an attempt to create a backup
2. Link every folder/file in `Configs` to `~/.config/<folder/file>`
3. Link `Assets` to `~/.config/rice_assets`
4. Link `Bscripts` to `~/.bscripts`
5. Link `Walcache` to `~/.cache/wal`
6. Copy every font at `~/.local/share/fonts/` to `Fonts`
7. Link `Fonts` to `~/.local/share/fonts`
8. Change permissions of all scripts in the repo to be executable

Additional steps for configuring a colorscheme based Gtk theme:
1. Run `lxappearance`
2. Select "FlatColor" in the widgets section 
<img src="https://user-images.githubusercontent.com/98569017/217688736-09199751-0e3d-4c43-8114-11694ddbb948.png" width=80%>
And that's it, this will make all your Gtk applications follow the colorscheme extracted from your wallpaper.

  <br></br>
If you had previously installed this rice before the [refactor PR merge](https://github.com/ikz87/dots-2.0/pull/34), I'd advice you reinstall and then probably delete the following folders and their contents:
- `~/Documents/Sounds`
- `~/Pictures/Important`
- `~/Pictures/Wallpapers`

All those files are now stored at `~/.config/rice_assets`.

## Updating
Since the install script now uses symbolic links instead of copied files, all you have to do to update your configs to the latest version is to update the repo with `git pull`.

## Keybinds
| Key combo               | Action |
|   ---                   |  ---   |
| `Super+Return`            | Pause/Resume sxhkd |
| `Control+Alt+W`           | Open browser (brave is default) |
| `Control+Alt+T`           | Open terminal (kitty is default) |
| `Control+Alt+F`           | Open file manager (thunar is default) | 
| `Super+P`                 | Toggle picom |
| `Super+Shift+E`           | Open rofi in drun mode (app launcher) |
| `Alt+Tab`                 | Windows-like window switcher using rofi |
| `Super+Shift+Q`           | Show logout menu |
| `Print`                   | Take a screenshot (Saved to ~/Pictures/Screenshots and clipboard) |
| `Super+Print`             | Same as above, but with 3 second delay | 
| `Control+Alt+C`           | Color picker, copies color at cursor to clipboard in HEX on click |
| `Super+O`                 | Locks the PC (PC suspends after 5 seconds of inactivity while locked) |
| `Super+Space`             | Change keyboard layout (Cycles between us spanish and us english layouts) |
| `Super+C`                 | Close focused window | 
| `Alt+F4`                  | Force closing focused window (for frozen programs) | 
| `Control+Period`          | Move focused window to next workspace |
| `Control+Comma`            | Move focused window to previous workspace |
| `Control+Alt+Period`      | Go to next workspace | 
| `Control+Alt+Comma`       | Go to previous workspace | 
| `Super+{1,2,3,4,5}`       | Jump to workspaces 1 through 5 |
| `Alt+Period`              | Raise the volume by 5% (Warning: No volume cap set, you really shouldn't go above 150%) | 
| `Alt+Comma`               | Lower the volume by 5% |
| `Alt+M`                   | Toggle mute volume | 
| `Alt+Shift+Period`        | Raise brightness by 5% | 
| `Alt+Shift+Comma`         | Lower brightness by 5% | 
| `Control+Alt+X`           | Raise monitor gamma by 5% | 
| `Control+Alt+Z`           | Lower monitor gamma by 5% | 
| `Control+Alt+E`           | Toggle status bar |
| `Super+M`                 | Toggle eww media control window | 
| `Super+S`                 | Toggle monocle BSPWM layout | 
| `Control+Alt+Space`       | Toggle floating mode on focused window | 
| `Super+Shift+{K,J,H,L}`   | Move window |
| `Super+{K,J,H,L}`         | Select window |
| `Super+Alt+{K,J,H,L}`     | Grow focused window in desired direction | 
| `Control+Shift+{K,J,H,L}` | Shrink focused window in desired direction | 
| `Super+{D,A}`             | Rotate BSPWM tree at node (clockwise/counterclockwise) |
| `Alt+{D,A}`               | Rotate windows at node (clockwise/counterclockwise) |
| `Super+E`                 | Equalize window sizes |
| `Super+F`                 | Toggle fullscreen |
| `Super+KP_Add`            | Raise window gaps by 5px |
| `Super+KP_Subtract`       | Lower window gaps by 5px |
| `Control+Alt+{K,J,H,L}`   | Preselect direction for next window | 
| `Control+Alt+A`           | Cycle through window layers (above, normal or below) | 

These are all the keybinds set in the `~/.config/bspwm/sxhkdrc` file, however, if you are gonna use this as your daily driver, I highly encourage you to read that file in its entirity at least once, so you know what's going on behind the scenes.

Media keys should also work for controlling play/pause and changing volume.
