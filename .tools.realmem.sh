#!/bin/sh
raw="$(cat /proc/meminfo)"
totmem="$(echo $(echo "$raw" | grep MemTotal) | cut -d ' ' -f 2)"
freemem="$(echo $(echo "$raw" | grep MemFree) | cut -d ' ' -f 2)"
buffmem="$(echo $(echo "$raw" | grep Buffers) | cut -d ' ' -f 2)"
cachemem="$(echo $(echo "$raw" | grep Cached) | cut -d ' ' -f 2)"
realmem=$(($totmem - $freemem - $buffmem - $cachemem))
percmem="$(($realmem * 100 / $totmem))%"
realmem="$(($realmem / 1024))M"
echo "$realmem $percmem"
