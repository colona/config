#!/bin/sh

if synclient > /dev/null 2>&1; then
	current="$(synclient | grep TouchpadOff | cut -d '=' -f 2)"
	synclient TouchpadOff="$((1 - $current))"
elif xinput | grep -q 'Synaptics TouchPad'; then
	devid="$(xinput | sed -rn '/Synaptics TouchPad/s/.*id=([0-9]+).*/\1/gp')"
	current="$(xinput list-props $devid | sed -rn '/Device Enabled/s/.*\s+([10])$/\1/gp')"
	if [ "$current" -eq 0 ]; then
		xinput enable "$devid"
	else
		xinput disable "$devid"
	fi
fi
