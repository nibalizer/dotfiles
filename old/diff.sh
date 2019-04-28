#!/bin/bash

file=$1
if [ -z $file ]; then
    echo "Need filename"
    exit 1
fi

if ! [ -f $file ]; then
    echo "That file not tracked in dotfiles"
    exit 1
fi


diff $file ${HOME}/${file}
