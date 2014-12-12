#!/bin/sh
raw="$(head -5 /proc/meminfo)"
totmem="$(echo "$raw" | grep '^MemTotal:' | tr -s ' ' | cut -d ' ' -f 2)"
freemem="$(echo "$raw" | grep '^MemFree:' | tr -s ' ' | cut -d ' ' -f 2)"
buffmem="$(echo "$raw" | grep '^Buffers:' | tr -s ' ' | cut -d ' ' -f 2)"
cachemem="$(echo "$raw" | grep '^Cached:' | tr -s ' ' | cut -d ' ' -f 2)"
realmem=$(($totmem - $freemem - $buffmem - $cachemem))
percmem="$(($realmem * 100 / $totmem))%"
realmem="$(($realmem / 1024))M"
echo "$realmem $percmem"
