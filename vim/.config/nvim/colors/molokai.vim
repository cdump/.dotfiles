" Vim color file
"
" Based on the Molokai by
" Tomas Restrepo (https://github.com/tomasr/molokai)
"
" Modified by @cdump
"

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="molokai"

hi Boolean guifg=#af87ff
hi Character guifg=#ffd787
hi ColorColumn guibg=#303030
hi Comment guifg=#808080
hi Conditional guifg=#ff005f gui=bold
hi Constant guifg=#af87ff gui=bold
hi Cursor guifg=#000000 guibg=#dadada
hi CursorColumn guibg=#303030
hi CursorLine guibg=#303030
hi CursorLineNr guifg=#ff8700 gui=none
hi Debug guifg=#ffd7ff gui=bold
hi Define guifg=#5fd7ff
hi Delimiter guifg=#626262
hi DiffAdd guibg=#005f87
hi DiffChange guifg=#d7afaf guibg=#4e4e4e
hi DiffDelete guifg=#af005f guibg=#121212
hi DiffText guibg=#878787 gui=italic
hi Directory guifg=#87d75f gui=bold
hi Error guifg=#ffd787 guibg=#121212
hi ErrorMsg guifg=#ff00af guibg=#000000 gui=bold
hi Exception guifg=#afff00 gui=bold
hi Float guifg=#af87ff
hi FoldColumn guifg=#5f87af guibg=#000000
hi Folded guifg=#5f87af guibg=#000000
hi Function guifg=#afff00
hi Identifier guifg=#ff8700
hi Ignore guifg=#808080 guibg=#080808
hi IncSearch guifg=#d7ffaf guibg=#000000
hi Keyword guifg=#ff005f gui=bold
hi Label guifg=#ffffaf gui=none
hi LineNr guifg=#4e4e4e guibg=#262626
hi Macro guifg=#d7ffaf gui=italic
hi MatchParen guifg=#121212 guibg=#ff8700 gui=bold
hi ModeMsg guifg=#ffffaf
hi MoreMsg guifg=#ffffaf
hi NonText guifg=#4e4e4e
hi Normal guifg=#d0d0d0 guibg=#1c1c1c
hi Number guifg=#af87ff
hi Operator guifg=#ff005f
hi PreCondit guifg=#afff00 gui=bold
hi PreProc guifg=#afff00
hi Question guifg=#5fd7ff
hi Repeat guifg=#ff005f gui=bold
hi Search guifg=#2a2a2a guibg=#ffd787
hi SignColumn guifg=#87ff00 guibg=#262626
hi Special guifg=#5fd7ff guibg=bg gui=italic
hi SpecialChar guifg=#d7005f gui=bold
hi SpecialComment guifg=#8a8a8a gui=bold
hi SpecialKey guifg=#4e4e4e gui=italic
hi SpellBad guibg=#5f0000 gui=undercurl guisp=#FF0000
hi SpellCap guibg=#00005f gui=undercurl guisp=#7070F0
hi SpellLocal guibg=#00005f gui=undercurl guisp=#70F0F0
hi SpellRare gui=undercurl guisp=#FFFFFF
hi Statement guifg=#ff005f gui=bold
hi StatusLine guifg=#444444 guibg=#dadada
hi StatusLineNC guifg=#808080 guibg=#080808
hi StorageClass guifg=#ff8700 gui=italic
hi String guifg=#ffd787
hi Structure guifg=#5fd7ff
hi TabLine guifg=#808080 guibg=#1B1D1E gui=none
hi TabLineFill guifg=#1B1D1E guibg=#1B1D1E
hi Tag guifg=#ff005f gui=italic
hi Title guifg=#ff5f5f
hi Todo guifg=#ffffff guibg=#080808 gui=bold
hi Type guifg=#5fd7ff gui=none
hi Typedef guifg=#5fd7ff
hi Underlined guifg=#808080 gui=underline
hi VertSplit guibg=#1c1c1c guifg=#444444 gui=bold
hi Visual guibg=#444444
hi VisualNOS guibg=#444444
hi WarningMsg guifg=#ffffff guibg=#444444 gui=bold
hi WildMenu guifg=#5fd7ff guibg=#000000
hi iCursor guifg=#000000 guibg=#F8F8F0
hi keyword guifg=#d7005f

hi LspDiagnosticsDefaultError guifg=#d78787

hi GitSignsAdd guibg=#262626 guifg=#008100
hi GitSignsChange guibg=#262626 guifg=#b4b400
hi GitSignsDelete guibg=#262626 guifg=#cc0000

hi DiagnosticError guifg=#ff4c00

hi DiagnosticSignError guibg=#262626 guifg=#ff4c00
hi DiagnosticSignWarn guibg=#262626 guifg=#ffaf00
hi DiagnosticSignInfo guibg=#262626 guifg=#3664ac
hi DiagnosticSignHint guibg=#262626 guifg=#6490d4

" hi CmpItemAbbr guifg=#3fb7df
" hi CmpItemAbbrMatch guifg=#1fe7af gui=bold
" hi link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
"
hi CmpItemKind guifg=#6060b0
hi CmpItemMenu guifg=#505050
hi CmpItemAbbrMatch guifg=#b8f0d0 gui=bold

hi Pmenu guifg=#a8b0c0 guibg=#272727
hi PmenuSel guifg=#d8d8c0 guibg=#50cc50
hi PmenuSbar guibg=#161616
hi PmenuThumb guibg=#505050

" hi PmenuSel guibg=#4C566A
" hi PmenuSbar guibg=#3B4252
" hi PmenuThumb guibg=#C8D0E0
"


set background=dark
