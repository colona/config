#!/bin/sh

prog="$1"
path="$(mktemp)"
wget -O "$path" "$2"
$prog "$path"
