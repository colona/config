exec xscreensaver -no-splash &
exec setxkbmap us intl &
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
xinput --set-button-map 9 1 2 3 4 5 2 2 &
xrandr --output LVDS --auto --output VGA-0 --auto --below LVDS &
exec awesome
