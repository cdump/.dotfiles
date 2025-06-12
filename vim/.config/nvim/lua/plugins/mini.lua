return {
  'echasnovski/mini.nvim',
  version = false,
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      lazy = true,
      opts = {
        enable_autocmd = false,
      },
    },
  },
  config = function()
    require('mini.diff').setup({
      view = {
        signs = { add = '┃', change = '┃', delete = '_' },
      },
    })

    require('mini.comment').setup({
      mappings = {
        textobject = 'ic',
      },
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    local treesitter = require('mini.ai').gen_spec.treesitter
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        f = treesitter { a = '@function.outer', i = '@function.inner' },
        k = treesitter { a = '@block.outer', i = '@block.inner' },
        o = treesitter { a = { '@conditional.outer', '@loop.outer' }, i = { '@conditional.inner', '@loop.inner' } },
      },
    }

    require('mini.bracketed').setup {}

    require('mini.splitjoin').setup {
      mappings = {
        toggle = 'gs',
      }
    }

    local minialign = require('mini.align')
    minialign.setup {
      mappings = {
        start_with_preview = 'ga',
      },
      modifiers = {
        ['\\'] = function(steps, opts)
          opts.split_pattern = '\\%s*$'
          table.insert(steps.pre_justify, minialign.gen_step.trim())
        end
      },
    }
  end
}
