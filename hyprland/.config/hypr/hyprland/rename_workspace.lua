local utils = require("hyprland.utils")

local M = {}

function M.rename_current_workspace()
  local workspace = hl.get_active_workspace()
  if workspace == nil or workspace.id <= 0 then
    return
  end
  hl.exec_cmd(string.format([[
    NEW_NAME=$(
      rofi -dmenu -theme dmenu -p 'new name: ' -theme-str 'window{location:south;} *{font: "Sans 15";}'
    )
    if [ -n "${NEW_NAME}" ]; then
      hyprctl dispatch "hl.dsp.workspace.rename({workspace=%d, name=\"%s ${NEW_NAME}\"})";
    fi;
  ]], workspace.id, utils.format_subscript(workspace.id)))
end

return M
