#!/bin/bash

vms=`pgrep -lf VBoxHead | wc -l`
lxcs=`pgrep -lf lxc-start | wc -l`
echo $vms + $lxcs | bc
