vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'clangd',
    'pyright',
    'ruff',
    'lua_ls',
    'gopls',
    'golangci_lint_ls',
    'dockerls',
    'rust_analyzer',
    'biome',
    'yamlls',
    'vue_ls',
    'vtsls',
    'cssls',
    'tailwindcss',
  },
})
