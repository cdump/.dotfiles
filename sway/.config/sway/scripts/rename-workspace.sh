#!/bin/bash

prefix=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused).name'|cut -d' ' -f 1)
name=$(echo '' | bemenu -b -p "new name")
if [[ ! -z "$name" ]]; then
    wname="${prefix} ${name}"
    swaymsg "rename workspace to \"${wname}\";"
fi
