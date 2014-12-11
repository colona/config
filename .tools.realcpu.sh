#!/bin/sh

function readfield {
	echo "$(grep 'cpu ' /proc/stat | tr -s ' ' | cut -d ' ' -f "$1")"
}

previdle=$(($(readfield 5) + $(readfield 6)))
prevuser=$(($(readfield 2) + $(readfield 3)))
prevsys=$(($(readfield 4) + $(readfield 7) + $(readfield 8) + $(readfield 9)))

sleep "$1"

idle=$(($(readfield 5) + $(readfield 6) - $previdle))
user=$(($(readfield 2) + $(readfield 3) - $prevuser))
sys=$(($(readfield 4) + $(readfield 7) + $(readfield 8) + $(readfield 9) - $prevsys))
tot=$(($user + $sys + $idle))

percuser=$((100 * $user / $tot))
percsys=$((100 * $sys / $tot))
percsum=$((100 * ($user + $sys) / $tot))

echo "${percuser}+${percsys}=${percsum}%"
