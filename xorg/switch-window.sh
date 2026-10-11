#!/bin/bash
win_class=$1 # 'terminator' # $1

# get list of all windows matching with the class above
win_list=$(wmctrl -x -l | grep -i $win_class | awk '{print $1}' )

# get id of the focused window, padded the way wmctrl prints ids
# (xprop gives "0x800003, 0x0", wmctrl lists it as "0x00800003")
active_win_id=$(xprop -root _NET_ACTIVE_WINDOW | sed -n 's/.*# \(0x[0-9a-fA-F]*\).*/\1/p')
if [ -n "$active_win_id" ] && [ "$((active_win_id))" -ne 0 ]; then
    active_win_id=$(printf '0x%08x' "$active_win_id")
else
    active_win_id=""
fi

# get next window to focus on, the one after the active in the list
switch_to=$(echo $win_list | tr ' ' '\n' | sed -n "/^$active_win_id\$/{n;p;q}")

# if the current window is the last in the list ... take the first one
if [ "$switch_to" == '' ];then
   switch_to=$(echo $win_list | awk '{print $1}')
fi

# switch to window
wmctrl -i -a $switch_to
