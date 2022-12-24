#!/bin/bash

declare -a prefixes=("6:₆" "7:₇" "8:₈" "9:₉" "10:₁₀")
n=$(swaymsg -t get_workspaces | jq '[6,7,8,9,10] - [.[].num | select(. >= 6)] | min')

name=$(swaymsg -t get_tree |jq -r '.. |  (.nodes? // empty)[] |  (.nodes? // empty)[] | select(.focused==true) | .name')
wname="${prefixes[$((${n} - 6))]} ${name}"

swaymsg "move container to workspace \"${wname}\"; workspace \"${wname}\";"
