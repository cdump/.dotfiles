local M = {}

local colors = { '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF' }
local highlight_prefix = 'WordMark'

local active_matches = {}

for i, c in ipairs(colors) do
  vim.api.nvim_set_hl(0, highlight_prefix .. i, { bg = c, fg = 'Black' })
end

vim.api.nvim_create_autocmd('WinClosed', {
  group = vim.api.nvim_create_augroup('markword', { clear = true }),
  callback = function(ev)
    local winid = tonumber(ev.match)
    if winid then
      active_matches[winid] = nil
    end
  end,
})

local function current_word()
  local word = vim.fn.expand('<cword>')
  if word == '' then
    return nil
  end

  return word
end

local function word_pattern(word)
  return [[\V\<]] .. vim.fn.escape(word, [[\]]) .. [[\>]]
end

local function first_unused_highlight(matches)
  local used = {}

  for _, match in pairs(matches) do
    used[match.color] = true
  end

  for i = 1, #colors do
    if not used[i] then
      return i, highlight_prefix .. i
    end
  end

  return 1, highlight_prefix .. 1
end

local function window_matches(winid)
  if not vim.api.nvim_win_is_valid(winid) then
    active_matches[winid] = nil
    return {}
  end

  active_matches[winid] = active_matches[winid] or {}
  return active_matches[winid]
end

function M.toggle()
  local word = current_word()
  if not word then
    return
  end

  local winid = vim.api.nvim_get_current_win()
  local matches = window_matches(winid)
  local match = matches[word]

  if match then
    pcall(vim.fn.matchdelete, match.id, winid)
    matches[word] = nil
    return
  end

  local color, group = first_unused_highlight(matches)
  matches[word] = {
    color = color,
    id = vim.fn.matchadd(group, word_pattern(word), 10, -1, { window = winid }),
  }
end

return M
