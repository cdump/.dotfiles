vim.cmd [[language C]] -- Show VIM messages in English

-- nvim-tree: disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--[[ Space = leader key ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

--[[ plugins ]]
require('plugins')

--[[ colorscheme ]]
require('colorscheme')


--[[ general options ]]
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true
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
vim.cmd [[ autocmd FileType * setlocal formatoptions-=cro ]] -- Disable comments on Enter press
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>q', '<cmd>if len(filter(range(1, bufnr("$")), "buflisted(v:val)")) == 1|:quit|else|:bprevious|bdelete #|endif<cr>') -- close buffer or vim
vim.keymap.set('n', '<leader><leader>q', '<cmd>qall<cr>') -- close vim
vim.keymap.set('n', '<leader>v', '<cmd>set cursorcolumn!<cr>')
vim.keymap.set('n', '<leader>s', '<cmd>w<cr>')
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- [[ Visual mode move blocks ]]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--[[ Command mode ]]
require('command_mode')

--[[ Indentation ]]
vim.opt.expandtab = true -- Change tabs to spaces
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.

--[[ Search ]]
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ...unless we type a capital
vim.keymap.set('n', '//', '<cmd>nohlsearch<cr>') -- clear current search highlight


--[[ Splits ]]
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set('n', 'vv', '<cmd>vsplit<cr>') -- vertical split
vim.keymap.set('n', 'ss', '<cmd>split<cr>') -- horizontal split
vim.keymap.set('n', '<leader>w', '<C-w>w') -- jump to next split
vim.keymap.set('n', '+', '2<C-w>+')
vim.keymap.set('n', '-', '2<C-w>-')
vim.keymap.set('n', '>', '2<C-w>>')
vim.keymap.set('n', '<', '2<C-w><')


--[[ Jumps ]]
for i = 1, 9 do
    vim.keymap.set('n', '<M-' .. i .. '>', function() require('bufferline').go_to_buffer(i, true) end)
end
vim.keymap.set('n', '<leader>j', '<cmd>HopLine<cr>')
vim.keymap.set('n', '<leader>f', '<cmd>HopWord<cr>')
vim.keymap.set('v', '<Enter>', '<Plug>(EasyAlign)')


--[[ Fuzzy search ]]
vim.keymap.set('n', '<C-g>', require('telescope.builtin').git_files)
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>a', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>m', require('markword').toggle)
vim.keymap.set('n', '<leader>\'', require('telescope.builtin').marks)


--[[ File manager ]]
-- vim.keymap.set('n', '<C-\\>', '<cmd>Neotree source=filesystem position=left reveal_force_cwd<cr>')
vim.keymap.set('n', '<C-\\>', function() require('nvim-tree.api').tree.open({find_file=true}) end)

vim.keymap.set('n', '<leader>t', '<cmd>SymbolsOutline<cr>')

vim.keymap.set('n', '<leader>i', '<cmd>IndentBlanklineToggle<cr>')


vim.keymap.set('', '<leader>l', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
vim.keymap.set('n', '<leader>x', function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end)

require('lsp')

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.go' },
    callback = function() vim.lsp.buf.format() end,
})

vim.api.nvim_create_autocmd('Filetype', {
    pattern = { 'html', 'vue',  'css', 'scss', 'javascript', 'typescript' },
    command = 'setlocal shiftwidth=2 tabstop=2'
})
