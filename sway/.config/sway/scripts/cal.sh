#!/bin/sh

cal -y | jq -RMc '{"text":".", "alt": "shiftdel", "tooltip": [inputs]|join("\n")}'
