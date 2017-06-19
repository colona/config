#!/bin/sh

realcpu="$(~/.tools.realcpu.sh 3)"
cpuload="$(read l1 l2 l3 __ < /proc/loadavg; echo $l1 $l2 $l3)"
date="$(date +'%a %d %b %H:%M')"

if [ -x "$(command -v sensors)" ]; then
        temp="$(sensors | sed -rn '/temp1|Core/s/.*:\s+\+(\w+)\.\w+(°).*/\1\2/p')"
	temp="${temp//[$'\n']}"
fi
if [ -x "$(command -v acpi)" ]; then
        batt="$(acpi -b | cut -d ' ' -f 4)"
        batt=" [$(acpi -a | grep -q on-line && echo '=')${batt//[$'\n',]}]"
fi

echo "${temp}${batt} ${realcpu} (${cpuload}) $(~/.tools.realmem.sh)   $date"
sleep 1
