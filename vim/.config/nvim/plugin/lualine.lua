-- A blazing fast and easy to configure neovim statusline plugin written in pure lua
vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

require('lualine').setup({
  options = {
    globalstatus = true,
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = '', right = '' },
    refresh = {
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
        'RecordingEnter',
        'RecordingLeave',
      },
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'filename', path = 1 }, -- relative path
      'diagnostics',
    },
    lualine_c = {
      { 'searchcount', color = { fg = '#ff9e64' } },
      {
        function() return 'recording @' .. vim.fn.reg_recording() end,
        cond = function() return vim.fn.reg_recording() ~= '' end,
        color = { fg = '#ff9e64' },
      },
    },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'selectioncount', 'location' },
  },
})
