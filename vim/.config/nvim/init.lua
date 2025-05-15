vim.cmd([[language C]]) -- Show VIM messages in English

--[[ Space = leader key ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true

--[[ plugins ]]
require('plugins')

--[[ colorscheme ]]
require('colorscheme')

vim.opt.foldmethod = 'marker'
vim.o.fillchars = [[diff: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = 'auto'
vim.o.foldlevel = 99
vim.opt.foldlevelstart = 99

--[[ general options ]]
vim.opt.number = true -- show line numbers
-- vim.opt.relativenumber = true
vim.opt.showmode = false -- already have mode in lualine plugin
vim.opt.confirm = true -- raise a dialogue asking if you wish to save changed files
vim.opt.cursorline = true -- higlight current line
vim.opt.scrolloff = 5 -- minimal number of screen lines to keep above and below the cursor
vim.opt.linebreak = true -- do not break the words
vim.opt.mouse = '' -- disable mouse
vim.opt.swapfile = false
vim.opt.wildmode = 'longest:full,full'
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
vim.keymap.set('n', 'Ж', ':')
vim.cmd([[ autocmd FileType * setlocal formatoptions-=cro ]]) -- Disable comments on Enter press
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>q', '<cmd>if len(filter(range(1, bufnr("$")), "buflisted(v:val)")) == 1|:quit|else|:bprevious|bdelete #|endif<cr>') -- close buffer or vim
vim.keymap.set('n', '<leader><leader>q', '<cmd>qall<cr>') -- close vim
vim.keymap.set('n', '<leader>v', '<cmd>set cursorcolumn!<cr>')
-- vim.keymap.set('n', '<leader>s', '<cmd>w<cr>')
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>') -- FIXME add notify
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', "'", '`') -- use ' for mark jumps to row+column
vim.cmd([[set shortmess+=I]]) -- do not show :intro on start

-- [[ Visual mode move blocks ]]
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

--[[ Command mode ]]
require('command_mode')

--[[ Indentation ]]
vim.opt.expandtab = true -- Change tabs to spaces
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.

--[[ Search ]]
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ...unless we type a capital
vim.keymap.set('n', '//', '<cmd>nohlsearch<cr>', { desc = 'clear current search highlight' })
vim.keymap.set('n', '<leader>m', require('markword').toggle)

--[[ Splits ]]
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set('n', 'vv', '<cmd>vsplit<cr>', { desc = 'vertical split' })
vim.keymap.set('n', '<leader>w', '<C-w>w', { desc = 'jump to the next split' })
vim.keymap.set('n', '+', '2<C-w>+')
vim.keymap.set('n', '-', '2<C-w>-')
vim.keymap.set('n', '>', '2<C-w>>')
vim.keymap.set('n', '<', '2<C-w><')

vim.keymap.set('n', '<leader>ht', function() require('mini.diff').toggle_overlay() end)

--[[ Jumps ]]
for i = 1, 9 do
    vim.keymap.set('n', '<M-' .. i .. '>', function() require('bufferline').go_to_buffer(i, true) end)
end
vim.keymap.set('v', 'y', 'ygv<Esc>', { desc = 'do not move cursor to the start of selection' })

require('lsp')

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.go' },
    callback = function()
        vim.lsp.buf.format()
    end,
})

vim.api.nvim_create_autocmd('Filetype', {
    pattern = { 'html', 'vue', 'css', 'scss', 'javascript', 'typescript' },
    command = 'setlocal shiftwidth=2 tabstop=2',
})

-- highlighting on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ timeout = 500 })
    end,
    pattern = '*',
})
