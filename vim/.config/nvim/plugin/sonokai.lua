-- colorscheme
vim.pack.add({ 'https://github.com/sainnhe/sonokai' })

vim.cmd [[
    let g:sonokai_disable_italic_comment=1
    let g:sonokai_diagnostic_virtual_text='colored'
    let g:sonokai_disable_terminal_colors=1
    let g:sonokai_menu_selection_background='green'
    let g:sonokai_colors_override={'bg0':['#1e222a', '235'], 'bg2': ['#282c34', '236'], 'bg_green': ['#a3be8c','107']}

    colorscheme sonokai

    hi VertSplit guifg=#404040
    " hi DiffText guibg=#62a9ba
    hi Todo guifg=#ffffff guibg=#080808 gui=bold
    hi Directory guifg=#9ed072 gui=bold
    hi Macro guifg=#d7ffaf gui=italic
    hi Include guifg=#afdd00
    hi PreCondit guifg=#afdd00 gui=italic
    hi FloatBorder guibg=NONE guifg=#7f8490
    hi NormalFloat guifg=#a2a2a3 guibg=#1e222a
    hi HintFloat guifg=#9ed072 guibg=NONE
    hi! link Pmenu NormalFloat
    hi PmenuExtra guibg=NONE

    hi DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
    hi DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
    hi DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
    hi DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

    " hiphish/rainbow-delimiters.nvim
    hi rainbowcol1 guifg=#5fd7ff
    hi rainbowcol2 guifg=#ffffaf
    hi rainbowcol3 guifg=#afffff
    hi rainbowcol4 guifg=#ffd7ff
    hi rainbowcol5 guifg=#5fd7ff
    hi rainbowcol6 guifg=#ffffaf
    hi rainbowcol7 guifg=#afffff

    hi SnacksIndent guifg=#282c34

    hi MiniTrailspace guibg=#d78787

    hi BufferLineBufferSelected gui=bold
]]
