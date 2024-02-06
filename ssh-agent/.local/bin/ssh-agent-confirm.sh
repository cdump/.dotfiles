#!/bin/sh

export WAYLAND_DISPLAY=${WAYLAND_DISPLAY-wayland-1}
[[ `swaynag --type warning --edge bottom --layer bottom --message "Allow ssh-agent?" --button-dismiss-no-terminal "Allow" "echo 1" --dismiss-button "Disallow"` == "1" ]]
