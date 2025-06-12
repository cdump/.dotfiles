return {
  'mason-org/mason-lspconfig.nvim',
  opts = {
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
  },
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig'
  },
}
