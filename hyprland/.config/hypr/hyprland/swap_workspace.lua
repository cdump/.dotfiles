local utils = require("hyprland.utils")

local M = {}

local function name_for_id(workspace, id)
  local prefix = utils.format_subscript(workspace.id) .. " "
  if workspace.name:sub(1, #prefix) == prefix then
    return utils.format_subscript(id) .. " " .. workspace.name:sub(#prefix + 1)
  end
  if workspace.name == tostring(workspace.id) then
    return tostring(id)
  end
  return workspace.name
end

function M.swap_current_workspace(offset)
  local current = hl.get_active_workspace()
  if current == nil or current.id <= 0 or hl.get_active_special_workspace() ~= nil then
    return
  end

  local source_id = current.id
  local target_id = source_id + offset
  if target_id < 1 or target_id > 2147483647 or target_id == source_id then
    return
  end

  local target = hl.get_workspace(target_id)
  local current_name = name_for_id(current, target_id)
  local target_name = target and name_for_id(target, source_id)

  if target ~= nil then
    -- An ID must be unused before another workspace can take it.
    local used = { [source_id] = true, [target_id] = true }
    for _, workspace in ipairs(hl.get_workspaces()) do
      used[workspace.id] = true
    end
    local temporary_id = 1
    while used[temporary_id] do
      temporary_id = temporary_id + 1
    end

    hl.dispatch(hl.dsp.workspace.change_id({ workspace = target_id, id = temporary_id }))
    hl.dispatch(hl.dsp.workspace.change_id({ workspace = source_id, id = target_id }))
    hl.dispatch(hl.dsp.workspace.change_id({ workspace = temporary_id, id = source_id }))
    hl.dispatch(hl.dsp.workspace.rename({ workspace = source_id, name = target_name }))
  else
    hl.dispatch(hl.dsp.workspace.change_id({ workspace = source_id, id = target_id }))
  end

  hl.dispatch(hl.dsp.workspace.rename({ workspace = target_id, name = current_name }))
end

return M
