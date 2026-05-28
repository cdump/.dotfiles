return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.diff').setup({
      view = {
        signs = { add = '┃', change = '┃', delete = '_' },
      },
    })

    local treesitter = function(args)
      -- https://github.com/echasnovski/mini.nvim/issues/1864
      return require('mini.ai').gen_spec.treesitter(args, {use_nvim_treesitter = true})
    end
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        f = treesitter { a = '@function.outer', i = '@function.inner' },
        k = treesitter { a = '@block.outer', i = '@block.inner' },
        c = treesitter { a = '@comment.outer', i = '@comment.outer' },
        o = treesitter { -- code block
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        },
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

    require('mini.move').setup {}

    require('mini.trailspace').setup {}
    vim.api.nvim_set_hl(0, 'MiniTrailspace', { bg = '#d78787' })
    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function()
        require('mini.trailspace').trim()
        require('mini.trailspace').trim_last_lines()
      end,
    })
  end
}
