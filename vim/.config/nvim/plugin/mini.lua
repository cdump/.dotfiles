vim.pack.add({ 'https://github.com/echasnovski/mini.nvim' })

require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '┃', change = '┃', delete = '_' },
  },
})

local treesitter = require('mini.ai').gen_spec.treesitter
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
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(args)
    if not vim.bo[args.buf].modifiable or vim.bo[args.buf].buftype ~= '' then
      return
    end

    require('mini.trailspace').trim_last_lines()
    require('mini.trailspace').trim()
  end,
})
