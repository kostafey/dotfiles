
xrandr --output LVDS1 --off
xrandr --output VGA1 --mode 1680x1050
# xrandr --output LVDS1 --mode 1366x768

xset fp+ ~/.local/share/fonts
xset +fp ~/.local/share/fonts
xset fp rehash
# fc-cache -frv

xscreensaver -no-splash &

# setxkbmap -layout us,ru -variant -option grp:alt_shift_toggle,terminate:ctrl_alt_bksp &
xkbcomp "$HOME/.xkb" "$DISPLAY"
xcape -e '#50=ISO_Next_Group;#62=ISO_Next_Group;#64=ISO_Next_Group;#108=ISO_Next_Group' -t 1000
xxkb &

xrdb -merge ~/.Xresources &

stumpwm
