vim.pack.add({ 'https://github.com/OXY2DEV/markview.nvim' })

require('markview.extras.checkboxes').setup()

vim.keymap.set('n', '<leader>M', '<Cmd>Markview<CR>', { desc = 'Toggle Markview' })
vim.keymap.set({ 'n', 'v' }, '<leader><CR>', '<Cmd>Checkbox toggle<CR>', { desc = 'Toggle Checkbox' })
