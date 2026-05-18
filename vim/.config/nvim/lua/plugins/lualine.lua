-- A blazing fast and easy to configure neovim statusline plugin written in pure lua
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      globalstatus = true,
      component_separators = { left = ' ', right = ' ' },
      section_separators = { left = '', right = '' },
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
      lualine_z = { 'location' },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
      group = vim.api.nvim_create_augroup('lualine_macro_refresh', { clear = true }),
      callback = function()
        vim.schedule(function() require('lualine').refresh({ place = { 'statusline' } }) end)
      end,
    })
  end,
}
