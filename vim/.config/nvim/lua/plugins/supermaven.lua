return {
  'supermaven-inc/supermaven-nvim',
  cmd = {
    'SupermavenStart',
    'SupermavenToggle',
  },
  keys = {
    { '<leader>cm', '<cmd>SupermavenToggle<cr>', mode = 'n', desc = 'Toggle Supermaven' },
  },
  opts = {
    keymaps = {
      accept_suggestion = '<Tab>',
      clear_suggestion = '<C-]>',
      accept_word = '<C-j>',
    },
  },
}
