return {
  'supermaven-inc/supermaven-nvim',
  cmd = {
    'SupermavenStart',
    'SupermavenToggle',
  },
  keys = {
    { "<leader>cm", "<cmd>SupermavenToggle<cr>", mode = "n", desc = "Toggle Supermaven" },
  },
  opts = {
  },
}
