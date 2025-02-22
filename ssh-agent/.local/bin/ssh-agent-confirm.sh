#!/bin/sh

export WAYLAND_DISPLAY=${WAYLAND_DISPLAY-wayland-1}
notify-send 'Ssh key used'
# [[ `swaynag --type warning --edge bottom --layer bottom --message "$*" --button-dismiss-no-terminal "Allow" "echo 1" --dismiss-button "Disallow"` == "1" ]]
