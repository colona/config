HOSTNAME="$(hostname)"

case "$HOSTNAME" in
	klesk) xrandr --output LVDS --auto --output HDMI-0 --auto --right-of LVDS;;
	visor) xrandr --output eDP-1 --auto --output DP-2-2 --auto --above eDP-1;;
esac

xset -dpms
xset s off
xset b off
setxkbmap us -option compose:caps
redshift &
~/.tools.toggletouchpad.sh

case "$HOSTNAME" in
klesk|gorre|visor)
	mouse="$(xinput | sed -rn '/Optical Mouse/s/.*id=([0-9]+).*/\1/p')"
	if [ -n "$mouse" ]; then
		xinput --set-button-map "$mouse" 1 2 3 4 5 2 2
	fi
	if xinput | grep -q TrulyErgonomic.com; then
		xmodmap -e 'keycode 0x73 = Multi_key'
		xmodmap -e 'keycode 0x70 = Super_L'
		xmodmap -e 'keycode 0x75 = Super_L'
	fi;;
esac

while true; do xsetroot -name "$(~/.tools.statusbar.sh)"; done &

exec ~/.dwm/dwm &>> ~/.dwm/logs
