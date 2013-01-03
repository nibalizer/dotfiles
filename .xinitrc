#!/usr/bin/env bash


xcompmgr -fF -I-.002 -O-.003 -D1 &


export OOO_FORCE_DESKTOP=gnome
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

gnome-settings-daemon &
gnome-volume-manager &

setxkbmap us -variant colemak -option ctrl:nocaps
xrdb -load ~/.Xdefaults
$HOME/local/bin/setup-env.sh

exec xmonad

