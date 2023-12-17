local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_extend('force', lsp_capabilities, require('cmp_nvim_lsp').default_capabilities())
lsp_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

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

    -- ['pylsp'] = {
    --     plugins = {
    --         black = { enabled = false },
    --         autopep8 = { enabled = false },
    --         pyflakes = { enabled = false },
    --         yapf = { enabled = false },
    --         pycodestyle = { enabled = false },
    --     },
    -- },
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
    ['ruff_lsp'] = {},

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
        -- check = {
        --     command = "clippy"
        -- },
        completion = {
            fullFunctionSignatures = {
                enable = true,
            }
        },
        imports = {
            granularity = {
                group = "module",
            },
            -- prefix = "self",
        },
    },
}

for server_name, cfg in pairs(servers) do
    cfg.capabilities = lsp_capabilities
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
