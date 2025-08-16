vim.cmd.language('C') -- Show VIM messages in English

--[[ Space = leader key ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true
vim.opt.winborder = 'single'

require('config.lazy')
require('config.command_mode')
require('config.colorscheme')
require('config.lsp')
require('config.fold')
require('config.diagnostic')
require('config.splits')
require('config.autocmds')

--[[ general options ]]
vim.opt.shortmess:append('I') -- do not show :intro on start
vim.opt.number = true     -- show line numbers
vim.opt.showmode = false  -- already have mode in lualine plugin
vim.opt.confirm = true    -- raise a dialogue asking if you wish to save changed files
vim.opt.cursorline = true -- higlight current line
vim.opt.scrolloff = 5     -- minimal number of screen lines to keep above and below the cursor
vim.opt.linebreak = true  -- do not break the words
vim.opt.mouse = ''        -- disable mouse
vim.opt.swapfile = false
vim.opt.wildmode = 'longest:full,full'
vim.opt.langmap =
'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
vim.keymap.set('n', 'Ж', ':')
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>q',
  '<cmd>if len(filter(range(1, bufnr("$")), "buflisted(v:val)")) == 1|:quit|else|:bprevious|bdelete #|endif<cr>') -- close buffer or vim
vim.keymap.set('n', '<leader><leader>q', '<cmd>qall<cr>')
vim.keymap.set('n', '<leader>v', '<cmd>set cursorcolumn!<cr>')
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<cmd>w<cr>')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', "'", '`') -- use ' for mark jumps to row+column

--[[ Indentation ]]
vim.opt.expandtab = true -- Change tabs to spaces
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent.
vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for.

--[[ Search ]]
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true  -- ...unless we type a capital
vim.keymap.set('n', '//', '<cmd>nohlsearch<cr>', { desc = 'clear current search highlight' })
vim.keymap.set('n', '<leader>m', require('markword').toggle)

vim.keymap.set('n', '<leader>ht', function() require('mini.diff').toggle_overlay() end)

--[[ Jumps ]]
for i = 1, 9 do
  vim.keymap.set('n', '<M-' .. i .. '>', function() require('bufferline').go_to_buffer(i, true) end)
end
vim.keymap.set('v', 'y', 'ygv<Esc>', { desc = 'do not move cursor to the start of selection' })
