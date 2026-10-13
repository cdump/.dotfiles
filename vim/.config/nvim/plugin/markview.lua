vim.pack.add({
  'https://github.com/OXY2DEV/markview.nvim',
  'https://github.com/gunasekar/markview-smart-tables.nvim',
})

require('markview-smart-tables').setup({ wrap_width = 1 })

require('markview').setup({
  renderers = {
    -- Fit columns to the window and wrap overflowing text inside each cell.
    markdown_table = function(buffer, item)
      require('markview-smart-tables').render(buffer, item)
    end,
  },
})

require('markview.extras.checkboxes').setup()

vim.keymap.set('n', '<leader>M', '<Cmd>Markview<CR>', { desc = 'Toggle Markview' })
vim.keymap.set({ 'n', 'v' }, '<leader><CR>', '<Cmd>Checkbox toggle<CR>', { desc = 'Toggle Checkbox' })
