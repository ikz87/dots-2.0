#!/bin/sh
temp=$(sensors | grep 'Package id 0:\|Tdie' | grep ':[ ]*+[0-9]*.[0-9]*°C' -o | grep '[0-9]*.[0-9]*°C' -o)
temp=${temp::-4}
echo "$temp"
