#!/bin/bash

echo "setting up env"
xrdb -load ~/.Xdefaults
cd
$HOME/local/bin/notes.synclient
setxkbmap us -variant colemak -option ctrl:nocaps
feh --bg-center Images/xmbindings_lg.png


