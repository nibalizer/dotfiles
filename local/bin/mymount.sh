#!/bin/bash

mntinfo=$(until findmnt -n . ; do cd .. ; done)
fs=`echo $mntinfo | cut -d " " -f 3`
src=`echo $mntinfo | cut -d " " -f 2 | cut -d ':' -f 1 | cut -d "." -f 1`
if [ $fs != 'ext4' ]; then
   echo "($src,$fs)"
fi

