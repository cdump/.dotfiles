vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set('n', 'vv', '<cmd>vsplit<cr>', { desc = 'vertical split' })
vim.keymap.set('n', '<leader>w', '<C-w>w', { desc = 'jump to the next split' })
vim.keymap.set('n', '+', '2<C-w>+')
vim.keymap.set('n', '-', '2<C-w>-')
vim.keymap.set('n', '>', '2<C-w>>')
vim.keymap.set('n', '<', '2<C-w><')
