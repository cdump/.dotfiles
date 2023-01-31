local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_on_attach = require('lsp_on_attach').lsp_on_attach
require('mason-lspconfig').setup {
    automatic_installation = { exclude = { 'clangd' } },
}

local eslint_d = require('mason-registry').get_package('eslint_d')
if not eslint_d:is_installed() then eslint_d:install() end

for _, server_name in pairs({
    'clangd',
    'sumneko_lua',
    'pyright',
    'dockerls',
    'gopls',
    'golangci_lint_ls',
    'volar',
}) do
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
        -- go install mvdan.cc/gofumpt@latest
        cfg.settings = { gopls = { gofumpt = true } }
    elseif server_name == 'volar' then
        cfg.settings = { volar = { filetypes = { 'typescript', 'javascript', 'vue', 'json' } } }
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
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})

vim.keymap.set('n', '<C-k>', function()
    vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } })
end)
vim.keymap.set('n', '<C-j>', function()
    vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN } })
end)
vim.keymap.set('n', '<C-A-k>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<C-A-j>', vim.diagnostic.goto_next)
