-- A snazzy bufferline for Neovim
vim.pack.add({
  { src = 'https://github.com/akinsho/bufferline.nvim', version = vim.version.range('*') },
})

require('bufferline').setup({
  options = {
    numbers = function(opts) return opts.raise(opts.ordinal) end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    modified_icon = '',
    indicator = {
      style = 'none',
    },
  }
})
