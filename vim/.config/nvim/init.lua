vim.cmd [[language C]] -- Show VIM messages in English

--[[ Space = leader key ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--[[ plugins ]]
require('plugins')


--[[ colorscheme ]]
vim.opt.termguicolors = true
-- vim.cmd [[colorscheme molokai]]
vim.cmd [[
    let g:sonokai_disable_italic_comment=1
    let g:sonokai_diagnostic_virtual_text='colored'
    let g:sonokai_disable_terminal_colors=1
    let g:sonokai_menu_selection_background='green'
    let g:sonokai_colors_override={'bg0':['#1e222a', '235'], 'bg2': ['#282c34', '236'], 'bg_green': ['#a3be8c','107']}
    silent! colorscheme sonokai

    hi VertSplit guifg=#505050

    hi Todo guifg=#ffffff guibg=#080808 gui=bold
    hi Directory guifg=#9ed072 gui=bold
    hi Macro guifg=#d7ffaf gui=italic
    hi PreCondit guifg=#afdd00 gui=italic
    hi Include guifg=#afdd00
    hi BufferLineIndicatorSelected guifg=#75c3e2 guibg=#1e222a
    hi BufferLineBufferSelected guifg=#e2e2e3 guibg=#1e222a gui=bold
    hi FloatBorder guibg=#1e222a guifg=#7f8490
    hi PmenuThumb guibg=#7f8490

    hi NormalFloat guifg=#e2e2e3 guibg=#1e222a
    hi ErrorFloat guifg=#fc5d7c guibg=#1e222a
    hi WarningFloat guifg=#e7c664 guibg=#1e222a
    hi InfoFloat guifg=#76cce0 guibg=#1e222a
    hi HintFloat guifg=#9ed072 guibg=#1e222a

    " p00f/nvim-ts-rainbow
    hi rainbowcol1 guifg=#5fd7ff
    hi rainbowcol2 guifg=#ffffaf
    hi rainbowcol3 guifg=#afffff
    hi rainbowcol4 guifg=#ffd7ff
    hi rainbowcol5 guifg=#5fd7ff
    hi rainbowcol6 guifg=#ffffaf
    hi rainbowcol7 guifg=#afffff
]]

vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = 'DiagnosticSignHint' })



--[[ general options ]]
vim.opt.number = true -- show line numbers
vim.opt.confirm = true -- raise a dialogue asking if you wish to save changed files
vim.opt.cursorline = true -- higlight current line
vim.opt.scrolloff = 5 -- minimal number of screen lines to keep above and below the cursor
vim.opt.linebreak = true -- do not break the words
vim.opt.wildmode = 'longest:full,full'
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
vim.cmd [[ autocmd FileType * setlocal formatoptions-=cro ]] -- Disable comments on Enter press
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>q', '<cmd>if len(filter(range(1, bufnr("$")), "buflisted(v:val)")) == 1|:quit|else|:bprevious|bdelete #|endif<cr>') -- close buffer or vim
vim.keymap.set('n', '<leader><leader>q', '<cmd>qall<cr>') -- close vim
vim.keymap.set('n', '<leader>v', '<cmd>set cursorcolumn!<cr>')
vim.keymap.set('n', '<leader>s', '<cmd>w<cr>')


--[[ Command mode ]]
vim.keymap.set('c', '<C-k>', '<Left>')
vim.keymap.set('c', '<C-j>', '<Right>')
vim.keymap.set('c', '<C-A>', '<Home>')
vim.keymap.set('c', '<A-b>', '<S-Left>')
vim.keymap.set('c', '<A-f>', '<S-Right>')
vim.keymap.set('c', '<C-R>', '<Plug>(TelescopeFuzzyCommandSearch)')
vim.cmd [[
    cabbrev W w
    cabbrev Q q
    cabbrev WQ wq
    cabbrev Wq wq
]]


--[[ Indentation ]]
vim.opt.expandtab = true -- Change tabs to spaces
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.


--[[ Search ]]
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ...unless we type a capital
vim.keymap.set('n', '//', '<cmd>nohlsearch<cr>') -- clear current search highlight


--[[ Splits ]]
vim.keymap.set('n', 'vv', '<C-w>v<C-w>l') -- vertical split
vim.keymap.set('n', 'ss', '<C-w>s<C-w>j') -- horizontal split
vim.keymap.set('n', '<leader>w', '<C-w>w') -- jump to next split
vim.keymap.set('n', '+', '2<C-w>+')
vim.keymap.set('n', '-', '2<C-w>-')
vim.keymap.set('n', '>', '2<C-w>>')
vim.keymap.set('n', '<', '2<C-w><')


--[[ Jumps ]]
for i = 1, 9 do
    vim.keymap.set('n', '<M-' .. i .. '>', '<cmd>BufferLineGoToBuffer ' .. i .. '<cr>')
end
vim.keymap.set('n', '<leader>j', '<cmd>HopLine<cr>')
vim.keymap.set('n', '<leader>f', '<cmd>HopWord<cr>')
vim.keymap.set('v', '<Enter>', '<Plug>(EasyAlign)')


--[[ Fuzzy search ]]
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>a', require('telescope.builtin').live_grep)
-- nnoremap <leader>a :Ag<Space>
vim.keymap.set('n', '<leader>m', require('markword').toggle)


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
    severity_sort = true,
    float = {
        border = 'rounded',
    }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    -- virtual_text = {
    --     spacing = 3,
    --     severity_limit = 'Error',
    --     prefix = '·',
    -- },
})


vim.keymap.set('n', '<C-k>', function() vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } }) end)
vim.keymap.set('n', '<C-j>', function() vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN } }) end)
vim.keymap.set('n', '<C-A-k>', function() vim.diagnostic.goto_prev() end)
vim.keymap.set('n', '<C-A-j>', function() vim.diagnostic.goto_next() end)

vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.format()]]
