set nocompatible    " Be improved
language C          " Show VIM messages in English

" =============== Plugins Initialization ===============
" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
	execute '!mkdir -p ~/.vim/autoload'
	execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
source ~/.vim/plugins.vim

let mapleader = "\<Space>"

" =============== General ===============
syntax on           " Enable syntax highlighting
set autowrite       " Automatically save before commands like :next and :make
set confirm         " Raise a dialogue asking if you wish to save changed files
set autoread        " Reload unchanged buffers when file changed outside vim
set cursorline      " Higlight current line
set hidden          " Hides buffer with unsaved changes
set history=1000    " Store lots of :cmdline history
set nostartofline   " Stop certain movements from always going to the first character of a line

" set nowrap          " Nowrap long lines
set wrap            " Wrap long lines
set linebreak       " Do not break the words
set whichwrap+=<,>,h,l,[,]  " Automatically wrap left and right

set wildignore+=*.o,*.tmp,*.swp,*~,.git

set number          " Line numbers are good
set scrolloff=5     " Minimal number of screen lines to keep above and below the cursor.
set laststatus=2    " Always show status line
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set showmode        " Show current mode down the bottom
set title           " XTerm title
set ttimeoutlen=50  " Make Esc work faster
set wildmenu        " Enable wildmenu
set wildmode=longest:full,full
set backspace=indent,eol,start  " proper backspacing
set nrformats-=octal    " 0-prefixed numbers are still decimal
" set autochdir       " Set the working directory to wherever the open file lives

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

au FileType * setl fo-=cro " Disable comments on Enter press

" ================ Indentation ======================
set autoindent      " Keep indent from current line when starting a new line
set expandtab       " Change tabs to spaces
" set noexpandtab     " Do not change tabs to spaces
set smartindent
set smarttab        " sw at the start of the line, sts everywhere else
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set softtabstop=4
set tabstop=4       " Number of spaces that a <Tab> in the file counts for.

" ================ Search Settings  =================
set incsearch       " Find the next match as we type the search
set hlsearch        " Hilight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Fold Settings =================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" =============== GUI and colors ===============
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9   " Just font
set guioptions-=m   " hide menu
set guioptions-=T   " hide toolbar
set guioptions-=r   " hide scrollbar
set t_Co=256        " 256-color terminal
set background=dark

let g:rehash256 = 1   " for molokai theme
colorscheme molokai   " molokai theme
hi Visual ctermbg=238


" ============== Mappings =====================
" Clear current search highlight
nmap <silent> // :nohlsearch<CR>

cabbrev W w
cabbrev Q q
cabbrev WQ wq
cabbrev Wq wq

set pastetoggle=<F2>

" Toggle relativenumbers
nnoremap <Leader><Leader>r :set relativenumber!<CR>

nmap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>o :tabnew<CR>

inoremap <C-c> <Esc>

" HardMode
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Quick split
nnoremap <silent> vv <C-w>v<C-w>l
nnoremap <silent> ss <C-w>s<C-w>j

" Jump to next split
nnoremap <Leader>w <C-w>w

" Move around your splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Key repeat hack for resizing splits, i.e., <C-w>+++- vs <C-w>+<C-w>+<C-w>-
" see: http://www.vim.org/scripts/script.php?script_id=2223
nmap <C-w>+ <C-w>+<SID>ws
nmap <C-w>- <C-w>-<SID>ws
nmap <C-w>> <C-w>><SID>ws
nmap <C-w>< <C-w><<SID>ws
nnoremap <script> <SID>ws+ <C-w>+<SID>ws
nnoremap <script> <SID>ws- <C-w>-<SID>ws
nnoremap <script> <SID>ws> <C-w>><SID>ws
nnoremap <script> <SID>ws< <C-w><<SID>ws
nmap <SID>ws <Nop>

" Open the project tree and expose current file in the nerdtree with Ctrl-\
" nnoremap <silent> <C-\> :NERDTreeFind<CR>:vertical res 30<CR>
nnoremap <silent> <C-\> :NERDTreeFind<CR>

" Alt-N switch to Nth tab
" map 1 1gt
" map 2 2gt
" map 3 3gt
" map 4 4gt
" map 5 5gt
" map 6 6gt
" map 7 7gt
" map 8 8gt
" map 9 9gt

map 1 <Plug>AirlineSelectTab1
map 2 <Plug>AirlineSelectTab2
map 3 <Plug>AirlineSelectTab3
map 4 <Plug>AirlineSelectTab4
map 5 <Plug>AirlineSelectTab5
map 6 <Plug>AirlineSelectTab6
map 7 <Plug>AirlineSelectTab7
map 8 <Plug>AirlineSelectTab8
map 9 <Plug>AirlineSelectTab9

"set errorformat^=%-G%f:%l:%c:\ warning:\ %m,%-G%f:%l:%c:\ note:\ %m
let g:multi_cursor_quit_key='<C-c>'

let g:polyglot_disabled = ['cmake']

let g:peekaboo_window = 'vert bo 50new'

let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_error_symbol = "✗"
let g:ycm_warning_symbol = "⚠"
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <Leader>f :YcmCompleter FixIt<CR>
nnoremap <leader>g :YcmCompleter GoToDefinition<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" let g:lt_quickfix_list_toggle_map = '<leader>q'
" let g:lt_location_list_toggle_map = '<leader>L'
" nnoremap <leader>l :lnext<CR>

let g:gitgutter_max_signs = 1000

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline_theme='bubblegum'

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let $FZF_DEFAULT_COMMAND = 'ag -g "" --ignore "**.a"'

" EasyMotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Jump to line
map <Leader>j <Plug>(easymotion-bd-jk)
nmap <Leader>j <Plug>(easymotion-overwin-line)

" Jump to word bidirectional
map  <Leader>J <Plug>(easymotion-bd-w)
nmap <Leader>J <Plug>(easymotion-overwin-w)

" ultisnip
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-a>"

" Shortcut for :%s//
" nnoremap <leader>s :%s//gc<left><left><left>
" vnoremap <leader>s :s//gc<left><left><left>
nnoremap <leader>s :w<cr>

nnoremap <leader>c :tabnew <left><right>

noremap <leader>q :bp\|bd #<cr>

" Toggle Cursor Column
nmap <leader>v :set invcursorcolumn<CR>

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map <c-p> :FZF<CR>
nnoremap <leader>a :Ag<Space>
nmap <leader>b :Buffers<CR>

command! -bang Colors
  \ call fzf#vim#colors({'right': '10%', 'options': '--reverse'}, <bang>0)

command! -bang Buffers
  \ call fzf#vim#buffers({'right': '15%', 'options': '--reverse'}, <bang>0)


inoremap <c-l> %"PRIu64"<Space>

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)
let g:easy_align_delimiters = { '\': { 'pattern': '\\' } }

" vim-go
" au FileType go nmap <Leader>i <Plug>(go-info)
" au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)

autocmd Filetype vue setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab

" function! Tabline()
"   let s = ''
"   for i in range(tabpagenr('$'))
"     let tab = i + 1
"     let buflist = tabpagebuflist(tab)
"     let bufignore = ['NERD_tree', 'nerdtree', 'tagbar', 'codi', 'help']
"     for b in buflist
"       let buftype = getbufvar(b, "&filetype")
"       if index(bufignore, buftype)==-1 "index returns -1 if the item is not contained in the list
"         let bufnr = b
"         break
"       elseif b==buflist[-1]
"         let bufnr = b
"       endif
"     endfor
"     let bufname = bufname(bufnr)
"     let bufmodified = getbufvar(bufnr, "&mod")
"     let s .= '%' . tab . 'T'
"     let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
"     let s .= ' ' . tab .':'
"     let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')
"     if bufmodified
"       let s .= '[+] '
"     endif
"   endfor
"   let s .= '%#TabLineFill#'
"   return s
" endfunction
" set tabline=%!Tabline()

