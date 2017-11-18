#!/bin/sh
exec < /proc/meminfo
read __ totmem __
read __
read __ availmem __
realmem=$((totmem - availmem))
percmem="$((realmem * 100 / totmem))%"
realmem="$((realmem / 1024))M"
echo "$realmem $percmem"
