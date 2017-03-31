#!/bin/sh

readstat() {
	read usr nic sys idl iow irq sfi stl wtv < /proc/stat
	idle=$((idl + iow))
	user=$((usr + nic))
	system=$((sys + irq + sfi + stl))
	echo "$idle $user $system"
}

oldres=($(readstat))
sleep "$1"
res=($(readstat))
diff=(
	$((res[0] - oldres[0]))
	$((res[1] - oldres[1]))
	$((res[2] - oldres[2]))
)

total=$((diff[0] + diff[1] + diff[2]))
prcusr=$((100 * diff[1] / total))
prcsys=$((100 * diff[2] / total))
prcsum=$((100 * (diff[1] + diff[2]) / total))

echo "${prcusr}+${prcsys}=${prcsum}%"
