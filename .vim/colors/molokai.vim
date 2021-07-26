" Vim color file
"
" Based on the Molokai by
" Tomas Restrepo (https://github.com/tomasr/molokai)
"

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="molokai"

hi Boolean ctermfg=141
hi Boolean guifg=#af87ff
hi Character ctermfg=222
hi Character guifg=#ffd787
hi ColorColumn ctermbg=236
hi ColorColumn guibg=#303030
hi Comment ctermfg=244
hi Comment guifg=#808080
hi Conditional ctermfg=197 cterm=bold
hi Conditional guifg=#ff005f gui=bold
hi Constant ctermfg=141 cterm=bold
hi Constant guifg=#af87ff gui=bold
hi Cursor ctermfg=16 ctermbg=253
hi Cursor guifg=#000000 guibg=#dadada
hi CursorColumn ctermbg=236
hi CursorColumn guibg=#303030
hi CursorLine ctermbg=236 cterm=none
hi CursorLine guibg=#303030
hi CursorLineNr ctermfg=208 cterm=none
hi CursorLineNr guifg=#ff8700 gui=none
hi Debug ctermfg=225 cterm=bold
hi Debug guifg=#ffd7ff gui=bold
hi Define ctermfg=81
hi Define guifg=#5fd7ff
hi Delimiter ctermfg=241
hi Delimiter guifg=#626262
hi DiffAdd ctermbg=24
hi DiffAdd guibg=#005f87
hi DiffChange ctermfg=181 ctermbg=239
hi DiffChange guifg=#d7afaf guibg=#4e4e4e
hi DiffDelete ctermfg=125 ctermbg=233
hi DiffDelete guifg=#af005f guibg=#121212
hi DiffText ctermbg=102 cterm=bold
hi DiffText guibg=#878787 gui=italic
hi Directory ctermfg=113 cterm=bold
hi Directory guifg=#87d75f gui=bold
hi Error ctermfg=222 ctermbg=233
hi Error guifg=#ffd787 guibg=#121212
hi ErrorMsg ctermfg=199 ctermbg=16 cterm=bold
hi ErrorMsg guifg=#ff00af guibg=#000000 gui=bold
hi Exception ctermfg=154 cterm=bold
hi Exception guifg=#afff00 gui=bold
hi Float ctermfg=141
hi Float guifg=#af87ff
hi FoldColumn ctermfg=67 ctermbg=16
hi FoldColumn guifg=#5f87af guibg=#000000
hi Folded ctermfg=67 ctermbg=16
hi Folded guifg=#5f87af guibg=#000000
hi Function ctermfg=154
hi Function guifg=#afff00
hi Identifier ctermfg=208 cterm=none
hi Identifier guifg=#ff8700
hi Ignore ctermfg=244 ctermbg=232
hi Ignore guifg=#808080 guibg=#080808
hi IncSearch ctermfg=193 ctermbg=16
hi IncSearch guifg=#d7ffaf guibg=#000000
hi Keyword ctermfg=197 cterm=bold
hi Keyword guifg=#ff005f gui=bold
hi Label ctermfg=229 cterm=none
hi Label guifg=#ffffaf gui=none
hi LineNr ctermfg=239 ctermbg=235
hi LineNr guifg=#4e4e4e guibg=#262626
hi Macro ctermfg=193
hi Macro guifg=#d7ffaf gui=italic
hi MatchParen ctermfg=233 ctermbg=208 cterm=bold
hi MatchParen guifg=#121212 guibg=#ff8700 gui=bold
hi ModeMsg ctermfg=229
hi ModeMsg guifg=#ffffaf
hi MoreMsg ctermfg=229
hi MoreMsg guifg=#ffffaf
hi NonText ctermfg=239
hi NonText guifg=#4e4e4e
hi Normal ctermfg=252 ctermbg=234
hi Normal guifg=#d0d0d0 guibg=#1c1c1c
hi Number ctermfg=141
hi Number guifg=#af87ff
hi Operator ctermfg=197
hi Operator guifg=#ff005f
hi Pmenu ctermfg=81 ctermbg=16
hi Pmenu guifg=#5fd7ff guibg=#000000
hi PmenuSbar ctermbg=232
hi PmenuSbar guibg=#080808
hi PmenuSel ctermfg=255 ctermbg=242
hi PmenuSel guifg=#eeeeee guibg=#6c6c6c
hi PmenuThumb ctermfg=81
hi PmenuThumb guifg=#5fd7ff
hi PreCondit ctermfg=154 cterm=bold
hi PreCondit guifg=#afff00 gui=bold
hi PreProc ctermfg=154
hi PreProc guifg=#afff00
hi Question ctermfg=81
hi Question guifg=#5fd7ff
hi Repeat ctermfg=197 cterm=bold
hi Repeat guifg=#ff005f gui=bold
hi Search ctermfg=0 ctermbg=222 cterm=NONE
hi Search guifg=#2a2a2a guibg=#ffd787
hi SignColumn ctermfg=118 ctermbg=235
hi SignColumn guifg=#87ff00 guibg=#262626
hi Special ctermfg=81
hi Special guifg=#5fd7ff guibg=bg gui=italic
hi SpecialChar ctermfg=161 cterm=bold
hi SpecialChar guifg=#d7005f gui=bold
hi SpecialComment ctermfg=245 cterm=bold
hi SpecialComment guifg=#8a8a8a gui=bold
hi SpecialKey ctermfg=239
hi SpecialKey guifg=#4e4e4e gui=italic
hi SpellBad ctermbg=52
hi SpellBad guibg=#5f0000 gui=undercurl guisp=#FF0000
hi SpellCap ctermbg=17
hi SpellCap guibg=#00005f gui=undercurl guisp=#7070F0
hi SpellLocal ctermbg=17
hi SpellLocal guibg=#00005f gui=undercurl guisp=#70F0F0
hi SpellRare ctermfg=none ctermbg=none cterm=reverse
hi SpellRare gui=undercurl guisp=#FFFFFF
hi Statement ctermfg=197 cterm=bold
hi Statement guifg=#ff005f gui=bold
hi StatusLine ctermfg=238 ctermbg=253
hi StatusLine guifg=#444444 guibg=#dadada
hi StatusLineNC ctermfg=244 ctermbg=232
hi StatusLineNC guifg=#808080 guibg=#080808
hi StorageClass ctermfg=208
hi StorageClass guifg=#ff8700 gui=italic
hi String ctermfg=222
hi String guifg=#ffd787
hi Structure ctermfg=81
hi Structure guifg=#5fd7ff
hi TabLine guifg=#808080 guibg=#1B1D1E gui=none
hi TabLineFill guifg=#1B1D1E guibg=#1B1D1E
hi Tag ctermfg=197
hi Tag guifg=#ff005f gui=italic
hi Title ctermfg=203
hi Title guifg=#ff5f5f
hi Todo ctermfg=231 ctermbg=232 cterm=bold
hi Todo guifg=#ffffff guibg=#080808 gui=bold
hi Type ctermfg=81 cterm=none
hi Type guifg=#5fd7ff gui=none
hi Typedef ctermfg=81
hi Typedef guifg=#5fd7ff
hi Underlined ctermfg=244 cterm=underline
hi Underlined guifg=#808080 gui=underline
hi VertSplit ctermfg=244 ctermbg=232 cterm=bold
hi VertSplit guifg=#808080 guibg=#080808 gui=bold
hi Visual ctermbg=238
hi Visual guibg=#444444
hi VisualNOS ctermbg=238
hi VisualNOS guibg=#444444
hi WarningMsg ctermfg=231 ctermbg=238 cterm=bold
hi WarningMsg guifg=#ffffff guibg=#444444 gui=bold
hi WildMenu ctermfg=81 ctermbg=16
hi WildMenu guifg=#5fd7ff guibg=#000000
hi iCursor guifg=#000000 guibg=#F8F8F0
hi keyword ctermfg=161 cterm=bold
hi keyword guifg=#d7005f

hi LspDiagnosticsDefaultError ctermfg=1 guifg=#d78787

set background=dark
