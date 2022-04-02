#!/bin/bash
win_class=$1
launch_command=$2
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if test $(wmctrl -x -l | grep $win_class | wc -l) -gt 0; 
then 
    $SCRIPT_DIR/switch-window.sh $win_class
else
    $launch_command
fi