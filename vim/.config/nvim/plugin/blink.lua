vim.pack.add({
  'https://github.com/saghen/blink.lib',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/saghen/blink.cmp'
})

---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
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
}

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup(opts)
