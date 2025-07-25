-- highlight, edit, and navigate code using a fast incremental parsing library
return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'css',
      'diff',
      'go',
      'html',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'regex',
      'rust',
      'typescript',
      'vim',
      'vimdoc',
      'vue',
      'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
      disable = { 'c', 'cpp' },       -- bfrg/vim-cpp-modern is better (#if 0 support, auto type support, ...)
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        node_decremental = '<C-A-space>',
      },
    }
  }
}
