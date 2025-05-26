#!/bin/sh

(curl --max-time 2 -s 'https://wttr.in/Tbilisi?format=%c%t' || echo '?') | awk '{print "<span font=\"Noto Color Emoji\">"$1"</span> "$2}'
