
xrandr --output LVDS-1 --off
xrandr --output VGA-1 --mode 1680x1050

xset fp+ /home/kostafey/.fonts
xset +fp /home/kostafey/.fonts
xset fp rehash

xscreensaver -no-splash &

# setxkbmap -layout us,ru -variant -option grp:alt_shift_toggle,terminate:ctrl_alt_bksp &
xkbcomp "$HOME/.xkb" "$DISPLAY"
xcape -e '#50=ISO_Next_Group;#62=ISO_Next_Group;#64=ISO_Next_Group;#108=ISO_Next_Group' -t 1000
kbdd &
xxkb &

xrdb -merge ~/.Xresources &

stumpwm
