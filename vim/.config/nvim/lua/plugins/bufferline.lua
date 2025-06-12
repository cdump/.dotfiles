-- A snazzy bufferline for Neovim
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      numbers = function(opts) return opts.raise(opts.ordinal) end,
      show_buffer_close_icons = false,
      show_close_icon = false,
      modified_icon = '',
      indicator = {
        style = 'none',
      },
    }
  }
}
