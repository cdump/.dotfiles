return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',     -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<C-\\>', '<Cmd>Neotree reveal_force_cwd toggle<CR>' },
  },
  lazy = false,   -- neo-tree will lazily load itself
  opts = {
    close_if_last_window = true,
    enable_diagnostics = false,
    open_files_in_last_windows = false,     -- false = open files in top left window
    default_component_configs = {
      indent = {
        indent_size = 1,
        padding = 1
      },
      name = {
        use_git_status_colors = false,
      },
    },
  },
}
