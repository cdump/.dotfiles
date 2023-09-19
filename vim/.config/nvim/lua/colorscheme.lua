vim.cmd [[
    let g:sonokai_disable_italic_comment=1
    let g:sonokai_diagnostic_virtual_text='colored'
    let g:sonokai_disable_terminal_colors=1
    let g:sonokai_menu_selection_background='green'
    let g:sonokai_colors_override={'bg0':['#1e222a', '235'], 'bg2': ['#282c34', '236'], 'bg_green': ['#a3be8c','107']}
    silent! colorscheme sonokai

    hi VertSplit guifg=#404040
    hi NvimTreeWinSeparator guifg=#222327 guibg=#222327
    hi NvimTreeCursorLine guibg=#383838

    hi IndentBlanklineChar guifg=#282c34

    hi BufferLineBufferSelected guifg=#e2e2e3 guibg=#1e222a gui=bold

    hi Todo guifg=#ffffff guibg=#080808 gui=bold
    hi Directory guifg=#9ed072 gui=bold
    hi Macro guifg=#d7ffaf gui=italic
    hi PreCondit guifg=#afdd00 gui=italic
    hi Include guifg=#afdd00
    hi FloatBorder guibg=#1e222a guifg=#7f8490
    hi PmenuThumb guibg=#7f8490

    hi NormalFloat guifg=#e2e2e3 guibg=#1e222a
    hi ErrorFloat guifg=#fc5d7c guibg=#1e222a
    hi WarningFloat guifg=#e7c664 guibg=#1e222a
    hi InfoFloat guifg=#76cce0 guibg=#1e222a
    hi HintFloat guifg=#9ed072 guibg=#1e222a

    " hiphish/rainbow-delimiters.nvim
    hi rainbowcol1 guifg=#5fd7ff
    hi rainbowcol2 guifg=#ffffaf
    hi rainbowcol3 guifg=#afffff
    hi rainbowcol4 guifg=#ffd7ff
    hi rainbowcol5 guifg=#5fd7ff
    hi rainbowcol6 guifg=#ffffaf
    hi rainbowcol7 guifg=#afffff
]]

-- vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
-- vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
-- vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
-- vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = 'DiagnosticSignHint' })
-- hl line number
vim.cmd [[
  highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]
