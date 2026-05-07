local M = {}

function M.focus_prev_window_on_current_workspace()
  local active_window = hl.get_active_window()
  if active_window == nil then
    return
  end
  local active_ws = active_window.workspace.id
  local prev_id, prev_addr = math.huge, nil
  for _, w in ipairs(hl.get_windows()) do
    if w.workspace.id == active_ws and w.focus_history_id > 0 and w.focus_history_id < prev_id then
      prev_id, prev_addr = w.focus_history_id, w.address
    end
  end
  if prev_addr == nil then
    return
  end
  hl.dispatch(hl.dsp.focus({ window = "address:" .. prev_addr }))
  hl.dispatch(hl.dsp.window.bring_to_top())
end

return M
