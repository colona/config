#!/bin/sh

readstat() {
	read __ usr nic sys idl iow irq sfi stl __ < /proc/stat
	idle=$((idl + iow))
	user=$((usr + nic))
	system=$((sys + irq + sfi + stl))
	echo "$idle $user $system"
}

oldres=($(readstat))
sleep "${1:-1}"
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
