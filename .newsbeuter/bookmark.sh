#!/bin/sh

url="$1"
case "$url" in
*feedproxy.google.com*)
	dst="$(curl -sI "$url" | sed -rn 's/Location: (.*)/\1/p')"
	if [ ${#dst} -gt 10 ]; then
		url="$dst"
	fi ;;
esac
echo "$url" >> ~/.newsbeuter/bookmarks
