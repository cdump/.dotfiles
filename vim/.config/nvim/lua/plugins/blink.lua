return {
  'saghen/blink.cmp',
  dependencies = {
    'saghen/blink.lib',
    'rafamadriz/friendly-snippets',
  },
  build = function()
    require('blink.cmp').build():pwait()
  end,


  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<C-n>'] = { 'show' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    signature = {
      enabled = true,
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      documentation = {
        auto_show = true,
      },
      menu = {
        draw = {
          columns = { { 'label' }, { 'kind' }, { 'source_name' } },
        },
      },
    },
    cmdline = {
      keymap = {
        preset = 'inherit',
        ['<Tab>'] = { 'show_and_insert', 'select_next' },
      },
      sources = {
        default = {
          'path',
          'cmdline',
          'buffer',
        }
      },
      completion = {
        menu = {
          auto_show = false,
        },
      }
    },
    fuzzy = {
      -- use_proximity = false,
    },
    sources = {
      providers = {
        path = {
          opts = {
            trailing_slash = false,
            show_hidden_files_by_default = true,
          },
        },
      },
    },
  },
}
