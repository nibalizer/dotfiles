#!/bin/bash

if `ifconfig | grep 131.252 > /dev/null`; then
    pkill deluge
fi
