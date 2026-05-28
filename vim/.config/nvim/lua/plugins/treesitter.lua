-- highlight, edit, and navigate code using a fast incremental parsing library
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  },
  config = function()
    local ts = require('nvim-treesitter')
    ts.setup()

    -- Pre-warm the parsers I use most so first-open is instant.
    ts.install({
      'bash',
      'c',
      'cpp',
      'css',
      'diff',
      'go',
      'html',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'regex',
      'rust',
      'typescript',
      'vim',
      'vimdoc',
      'vue',
      'yaml',
    })

    local function try_start(buf, lang)
      if pcall(vim.treesitter.start, buf, lang) then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        return true
      end
      return false
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = args.match
        -- bfrg/vim-cpp-modern is better for c/cpp (#if 0 support, auto type, ...)
        if ft == 'c' or ft == 'cpp' then return end
        local lang = vim.treesitter.language.get_lang(ft) or ft

        if try_start(args.buf, lang) then return end

        if vim.tbl_contains(ts.get_available(), lang) then
          vim.notify('treesitter: installing ' .. lang .. '...', vim.log.levels.INFO)
          ts.install(lang):await(function(err)
            vim.schedule(function()
              if err then
                vim.notify('treesitter: failed to install ' .. lang .. ': ' .. tostring(err), vim.log.levels.ERROR)
                return
              end
              vim.notify('treesitter: installed ' .. lang, vim.log.levels.INFO)
              if vim.api.nvim_buf_is_valid(args.buf) then
                try_start(args.buf, lang)
              end
            end)
          end)
        end
      end,
    })
  end,
}
