return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    routes = {
      {
        view = 'split',
        filter = { event = 'msg_show', min_height = 10 },
      },
      {
        filter = { event = 'msg_show', kind = 'search_count' },
        opts = { skip = true },
      },
      {
        filter = { event = 'msg_show', kind = '', find = 'written' },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'lsp',
          kind = 'progress',
          cond = function(message)
            return vim.tbl_get(message.opts,
              'progress', 'client') == 'null-ls'
          end
        },
        opts = { skip = true },
      },
    },
    cmdline = {
      enabled = true,
      view = 'cmdline',
      format = {
        cmdline = { conceal = false },
      },
    },
    lsp = {
      progress = {
        enabled = false,
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
    notify = {
      enabled = false,
    },
    views = {
      mini = {
        timeout = 8000,
        border = {
          style = 'single',
        },
        position = {
          row = -2,
          col = '100%',
        },
        win_options = {
          winblend = 0,           -- disable transparency
        },
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  }
}
