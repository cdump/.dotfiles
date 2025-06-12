-- A blazing fast and easy to configure neovim statusline plugin written in pure lua
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    return {
      options = {
        globalstatus = true,
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_b = { { 'filename', path = 1 } },         -- relative path
        lualine_c = {
          {
            require('noice').api.status.search.get,
            cond = require('noice').api.status.search.has,
            color = { fg = '#ff9e64' },
          },
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
        },
      }
    }
  end
}
