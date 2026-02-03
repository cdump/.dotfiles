return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  keys = {
    { '<leader>M', '<Cmd>Markview<CR>',        desc = 'Toggle Markview' },
    { '<leader><CR>',         '<Cmd>Checkbox toggle<CR>', desc = 'Toggle Checkbox', mode = { 'n', 'v' } },
  },
  config = function()
    require('markview.extras.checkboxes').setup()
  end,
}
