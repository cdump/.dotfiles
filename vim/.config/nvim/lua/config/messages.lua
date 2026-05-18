vim.opt.shortmess:append({
  S = true, -- hide search count in cmdline; lualine shows it instead
  W = true, -- hide "written" messages
  q = true, -- hide macro recording message in cmdline; lualine shows it instead
})

vim.opt.cmdheight = 0 -- hide cmdline when not in use; ui2 unhides it on ':'

-- Hide the global statusline while the cmdline is open so ui2's cmdline
-- visually takes its place instead of stacking under it.
local group = vim.api.nvim_create_augroup('cmdline_swap_statusline', { clear = true })
vim.api.nvim_create_autocmd('CmdlineEnter', {
  group = group,
  callback = function() vim.o.laststatus = 0 end,
})
vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = group,
  callback = function() vim.o.laststatus = 3 end,
})

local ok, ui2 = pcall(require, 'vim._core.ui2')
if not ok then
  return
end

ui2.enable({
  msg = {
    targets = {
      [''] = 'msg',         -- unknown/empty kind
      echo = 'msg',
      echomsg = 'msg',
      lua_print = 'msg',
      bufwrite = 'msg',
      wmsg = 'msg',
      emsg = 'msg',         -- errors persist in cmdline, don't time out
      list_cmd = 'pager',
      shell_out = 'pager',
      shell_err = 'pager',
      verbose = 'pager',
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.5,
      timeout = 4000,
    },
    pager = {
      height = 0.5,
    },
  },
})
