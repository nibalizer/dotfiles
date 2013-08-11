#!/bin/bash

energy_now=`cat /sys/class/power_supply/BAT0/energy_now`
energy_full=`cat /sys/class/power_supply/BAT0/energy_full`
voltage_now=`cat /sys/class/power_supply/BAT0/voltage_now`

decimal=`echo "5 k $energy_now $energy_full /  p" | dc`
time_remain=`echo "5 k $energy_now $voltage_now /  p" | dc`
percent=`echo "$decimal 100 * p" | dc`
notify-send -i "battery-medium" "$percent%" "$time_remain"



