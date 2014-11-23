HOSTNAME="$(hostname)"

case "$HOSTNAME" in
	klesk) xrandr --output LVDS --auto --output VGA-0 --auto --right-of LVDS;;
	visor) xrandr --output eDP1 --auto --output DP2 --auto --above eDP1;;
esac

xset -dpms
xset s off
xset b off
setxkbmap us -option compose:caps

if [ "$HOSTNAME" == "klesk" ]; then
	mouse="$(xinput | sed -rn '/Optical Mouse/s/.*id=([0-9]+).*/\1/gp')"
	if [ -n "$mouse" ]; then
		xinput --set-button-map "$mouse" 1 2 3 4 5 2 2
	fi
	if xinput | grep -q TrulyErgonomic.com; then
		xmodmap -e 'keycode 0x73 = Multi_key'
		xmodmap -e 'keycode 0x70 = Super_L'
		xmodmap -e 'keycode 0x75 = Super_L'
	fi
fi

while true; do
	date="$(date +'%a %b %d %H:%M')"
	cpuload="($(cat /proc/loadavg | awk '{ print $1, $2, $3}'))"

	if [ "$HOSTNAME" == "klesk" ]; then
		if acpi -a | grep -q on-line; then power='='; else power=''; fi
		batt="[${power}$(acpi -b | awk '{ print $4 }' | cut -d ',' -f 1)]"
		temp="$(echo $(sensors | grep temp1) | cut -f 2 -d ' ' | cut -f 2 -d '+' | cut -f 1 -d '.')°"
	fi
	if [ "$HOSTNAME" == "visor" ]; then
		if acpi -a | grep -q on-line; then power='='; else power=''; fi
		batt="${power}$(acpi -b | awk '{ print $4 }' | cut -d ',' -f 1 | tr '\n' ' ')"
		batt="[$(echo $batt)]"
		temp="$(echo $(sensors | grep Core\ 0) | cut -f 3 -d ' ' | cut -f 2 -d '+' | cut -f 1 -d '.')°"
		temp="$temp $(echo $(sensors | grep Core\ 1) | cut -f 3 -d ' ' | cut -f 2 -d '+' | cut -f 1 -d '.')°"
	fi

	xsetroot -name "${temp} ${batt}   $(~/.tools.realcpu.sh 3) ${cpuload}   $(~/.tools.realmem.sh)   $date"
	sleep 1
done &

exec ~/.dwm/dwm
