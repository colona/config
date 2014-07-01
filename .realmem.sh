#!/bin/sh
mem=$(free -m | head -2 | tail -1)
totmem=$(echo $mem | cut -f 2 -d ' ')
realmem=$(( $(echo $mem | cut -f 3 -d ' ') - $(echo $mem | cut -f 6 -d ' ') - $(echo $mem | cut -f 7 -d ' ') ))
percmem="$(($realmem * 100 / $totmem))%"
realmem+="M "
echo "$realmem $percmem"
