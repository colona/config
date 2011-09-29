#exec xscreensaver -no-splash &
exec setxkbmap us intl &
#xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
xinput --set-button-map 9 1 2 3 4 5 2 2 &
xrandr --output LVDS --auto --output VGA-0 --auto --below LVDS &
xset -dpms &
xset s off &

while true; do
	batt="$(acpi -b | awk '{ print $4 }' | cut -d ',' -f 1)"
	cpuload="$(cat /proc/loadavg | awk '{ print $1, $2, $3}')"
	date="$(date +'%a %b %d %H:%M')"
	xsetroot -name "$batt ($cpuload) $date"
	sleep 5
done &

exec ~/.dwm/dwm
