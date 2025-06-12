return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  build = 'cargo build --release',
  opts = {
    keymap = {
      preset = 'none',
      ['<C-n>'] = { 'show' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-e>'] = { 'cancel', 'fallback' },

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
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
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
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

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      use_nvim_cmp_as_default = true,
    },
    cmdline = {
      completion = {
        ghost_text = { enabled = false },
      },
      keymap = {
        preset = 'none',
        ['<Tab>'] = {
          'show_and_insert',
          'select_next'
        },
        ['<C-j>'] = { 'show', 'select_next', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<C-c>'] = { 'cancel', 'fallback' },
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then return { "buffer" } end
        if type == ":" then return { "cmdline" } end
        return {}
      end,
    },

    -- fuzzy = {
    --     sorts = {
    --         function(a, b)
    --             print(vim.inspect(a))
    --             return true
    --         end,
    --         'score', 'sort_text',
    --     },
    -- },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
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
  opts_extend = { "sources.default" }
}
