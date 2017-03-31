#!/bin/sh
exec < /proc/meminfo
read __ totmem __
read __ freemem __
read __
read __ buffmem __
read __ cachemem __
realmem=$((totmem - freemem - buffmem - cachemem))
percmem="$((realmem * 100 / totmem))%"
realmem="$((realmem / 1024))M"
echo "$realmem $percmem"
