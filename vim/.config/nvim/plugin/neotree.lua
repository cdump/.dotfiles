vim.pack.add({
  -- dependencies first so they are on rtp before neo-tree loads.
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3'),
  },
})

require('neo-tree').setup({
  filesystem = {
    hijack_netrw_behavior = "open_current",
  },
  close_if_last_window = true,
  enable_diagnostics = false,
  open_files_in_last_windows = false, -- false = open files in top left window
  default_component_configs = {
    indent = {
      indent_size = 1,
      padding = 1
    },
    name = {
      use_git_status_colors = false,
    },
  },
  window = {
    mappings = {
      ['<leader>q'] = 'close_window',
    },
  },
})

vim.keymap.set('n', '<C-\\>', '<Cmd>Neotree reveal_force_cwd toggle<CR>')
