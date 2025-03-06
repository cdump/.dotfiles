local lsp_on_attach = require('lsp_on_attach').lsp_on_attach
require('mason-lspconfig').setup {
    automatic_installation = { exclude = { 'clangd' } },
}

local eslint_d = require('mason-registry').get_package('eslint_d')
if not eslint_d:is_installed() then eslint_d:install() end

local servers = {
    ['clangd'] = {
        cmd = { 'clangd',
            '--background-index',
            '--clang-tidy',
            '--pch-storage=memory',
            '--completion-style=detailed',
            '-j=2',
        },
    },

    ['pyright'] = {
        settings = {
            python = {
                pythonPath = '.venv/bin/python',
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = false,
                    diagnosticMode = 'openFilesOnly',
                },
            },
        },
    },
    ['ruff'] = {},

    ['lua_ls'] = {
        settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
    },

    ['gopls'] = {
        settings = { gopls = { gofumpt = true } }
    },
    ['golangci_lint_ls'] = {},

    ['volar'] = {
        filetypes = { 'typescript', 'javascript', 'vue', 'json' }
    },

    ['dockerls'] = {},
    ['rust_analyzer'] = {
        settings = {
            ['rust-analyzer'] = {
                check = {
                    command = "clippy"
                },
            },
        },
    },
    ['biome'] = {},
}

for server_name, cfg in pairs(servers) do
    -- cfg.capabilities = vim.tbl_extend('force', cfg.capabilities, require('cmp_nvim_lsp').default_capabilities())
    cfg.capabilities = require('blink.cmp').get_lsp_capabilities(cfg.capabilities)
    cfg.on_attach = lsp_on_attach
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
local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
    return hover {
        border = 'rounded',
        focusable = false,
    }
end

vim.keymap.set('n', '<C-k>', function()
    vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } })
end)
vim.keymap.set('n', '<C-j>', function()
    vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN } })
end)
vim.keymap.set('n', '<C-A-k>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<C-A-j>', vim.diagnostic.goto_next)
