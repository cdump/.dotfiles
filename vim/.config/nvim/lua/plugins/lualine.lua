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
        lualine_a = { 'mode' },
        lualine_b = {
          {
            function() return '󰰣MAVEN' end,
            cond = function()
              local supermaven_config = require('lazy.core.config').plugins['supermaven-nvim']
              if not supermaven_config or not supermaven_config._.loaded then return false end
              return require('supermaven-nvim.api').is_running()
            end,
            separator = { left = '', right = '' },
            color = { bg = '#cf4d3a' },
          },
          { 'filename', path = 1 }, -- relative path
          'diagnostics',
        },
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
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      }
    }
  end
}
