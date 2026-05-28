return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  lazy = true,
  opts = {
    enable_autocmd = false,
  },
  init = function()
    -- Make native gc/gcc use context-aware commentstring for embedded
    -- languages (Vue SFCs, etc.). Triggers lazy-load on first comment.
    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == 'commentstring'
          and require('ts_context_commentstring.internal').calculate_commentstring()
          or get_option(filetype, option)
    end
  end,
}
