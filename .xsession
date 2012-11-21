xrandr --output LVDS --auto --output VGA-0 --auto --right-of LVDS
setxkbmap us -option compose:caps
xset -dpms
xset s off
xset b off

while true; do
	topout=$(echo `top -b -n 2 -d 1 | grep -E 'Cpu\(s\):' | tail -1`)
	cpuuse=$(($(echo $topout | cut -f 2 -d ' ' | cut -f 1 -d '%' | cut -f 1 -d '.') + $(echo $topout | cut -f 4 -d ' ' | cut -f 1 -d '%' | cut -f 1 -d '.')))

	date="$(date +'%a %b %d %H:%M')"
	batt="$(acpi -b | awk '{ print $4 }' | cut -d ',' -f 1)"
	cpuload="$(cat /proc/loadavg | awk '{ print $1, $2, $3}')"
	temp="$(sensors | grep temp1 | cut -f 9 -d ' ' | cut -f 2 -d '+' | cut -f 1 -d '.')"

	mem=$(free -m | head -2 | tail -1)
	totmem=$(echo $mem | cut -f 2 -d ' ')
	realmem=$(( $(echo $mem | cut -f 3 -d ' ') - $(echo $mem | cut -f 6 -d ' ') - $(echo $mem | cut -f 7 -d ' ') ))
	percmem=$(($realmem * 100 / $totmem))

	music=""
#	if [ "`mocp -Q '%state' 2>> /dev/null`" == PLAY ] || [ "`mocp -Q '%state' 2>>/dev/null`" == PAUSE ]; then
#		music="$(mocp -Q '%title')   "
#	fi

	xsetroot -name "${music}${temp}° [$batt] ${cpuuse}% ($cpuload) ${realmem}M ${percmem}%   $date"
	sleep 5
done &

exec ~/.dwm/dwm
