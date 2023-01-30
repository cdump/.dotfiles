vim.cmd [[language C]] -- Show VIM messages in English

--[[ Space = leader key ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
-- nnoremap <leader>a :Ag<Space>
vim.keymap.set('n', '<leader>m', require('markword').toggle)
vim.keymap.set('n', '<leader>\'', require('telescope.builtin').marks)


--[[ File manager ]]
vim.keymap.set('n', '<C-\\>', '<cmd>Neotree source=filesystem position=left reveal_force_cwd<cr>')
vim.keymap.set('n', '<leader>t', '<cmd>SymbolsOutline<cr>')


vim.keymap.set('', '<leader>l', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
vim.keymap.set('n', '<leader>x', function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end)
vim.keymap.set('n', '<leader><leader>n', function() require('telescope').extensions.notify.notify() end)
--[[ LSP ]]
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', '<leader>x', function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end, opts)
    vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.hover) -- useful for 'get varible type under cursor'
end
require('mason-lspconfig').setup {
    automatic_installation = { exclude = { 'clangd' } },
}
for _, server_name in pairs({ 'clangd', 'sumneko_lua', 'pyright', 'dockerls', 'gopls', 'golangci_lint_ls' }) do
    local cfg = {
        capabilities = lsp_capabilities,
        on_attach = lsp_on_attach
    }
    if server_name == 'clangd' then
        cfg.cmd = { 'clangd',
            '--background-index',
            '--clang-tidy',
            '--pch-storage=memory',
            '--completion-style=detailed',
            -- '--inlay-hints',
            '-j=2',
        }
    elseif server_name == 'pyright' then
        cfg.settings = { python = { pythonPath = '.venv/bin/python' } }
    elseif server_name == 'sumneko_lua' then
        cfg.settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
    elseif server_name == 'gopls' then
        cfg.settings = { gopls = { gofumpt = true } } -- go install mvdan.cc/gofumpt@latest
    end
    require('lspconfig')[server_name].setup(cfg)
end

vim.diagnostic.config({
    underline = false,
    virtual_text = false,
    -- virtual_text = {
    --     spacing = 3,
    --     severity_limit = 'Error',
    --     prefix = '·',
    -- },
    severity_sort = true,
    float = {
        border = 'rounded',
    }
})

vim.keymap.set('n', '<C-k>', function() vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } }) end)
vim.keymap.set('n', '<C-j>', function() vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN } }) end)
vim.keymap.set('n', '<C-A-k>', function() vim.diagnostic.goto_prev() end)
vim.keymap.set('n', '<C-A-j>', function() vim.diagnostic.goto_next() end)

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.go' },
    callback = function() vim.lsp.buf.format() end,
})

vim.api.nvim_create_autocmd('Filetype', {
    pattern = { 'html', 'vue',  'css', 'scss', 'javascript', 'typescript' },
    command = 'setlocal shiftwidth=2 tabstop=2'
})
