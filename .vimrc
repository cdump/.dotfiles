set nocompatible    " Be improved
language C          " Show VIM messages in English

" =============== Plugins Initialization ===============
" Load vim-plug
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

set wrap            " Wrap long lines
set linebreak       " Do not break the words
set whichwrap+=<,>,h,l,[,]  " Automatically wrap left and right

set wildignore+=*.o,*.tmp,*.swp,*~,.git

set number          " Line numbers are good
set updatetime=300
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
let &t_SI.="\e[6 q" " '|' cursor in insert mode
let &t_SR.="\e[2 q"
let &t_EI.="\e[2 q"


set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set undodir=~/.vim/undo/

au FileType * setl fo-=cro " Disable comments on Enter press

" ================ Indentation ======================
set autoindent      " Keep indent from current line when starting a new line
set expandtab       " Change tabs to spaces
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
silent! colorscheme molokai   " molokai theme
hi Visual ctermbg=238


" ============== Mappings =====================
" Clear current search highlight
nmap <silent> // :nohlsearch<CR>

cabbrev W w
cabbrev Q q
cabbrev WQ wq
cabbrev Wq wq

" set pastetoggle=<Leader>p

" Toggle relativenumbers
nnoremap <Leader><Leader>r :set relativenumber!<CR>

nmap <Leader>s :update<CR>

" nmap <Leader>t :TagbarToggle<CR>

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

function! Bye()
     if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
         :quit
     else
         :bprevious|bdelete #
    endif
endfunction
nnoremap <silent> <leader>q :call Bye()<CR>

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
nnoremap <silent> <C-\> :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle Cursor Column
nmap <silent> <leader>v :set invcursorcolumn<CR>

map <c-p> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>a :Ag<Space>
nnoremap <leader>e :edit<Space>

" Alt-N switch to Nth tab
if has('nvim')
    map <M-1> <Plug>AirlineSelectTab1
    map <M-2> <Plug>AirlineSelectTab2
    map <M-3> <Plug>AirlineSelectTab3
    map <M-4> <Plug>AirlineSelectTab4
    map <M-5> <Plug>AirlineSelectTab5
    map <M-6> <Plug>AirlineSelectTab6
    map <M-7> <Plug>AirlineSelectTab7
    map <M-8> <Plug>AirlineSelectTab8
    map <M-9> <Plug>AirlineSelectTab9
else
    map 1 <Plug>AirlineSelectTab1
    map 2 <Plug>AirlineSelectTab2
    map 3 <Plug>AirlineSelectTab3
    map 4 <Plug>AirlineSelectTab4
    map 5 <Plug>AirlineSelectTab5
    map 6 <Plug>AirlineSelectTab6
    map 7 <Plug>AirlineSelectTab7
    map 8 <Plug>AirlineSelectTab8
    map 9 <Plug>AirlineSelectTab9
endif

let g:peekaboo_window = 'vert bo 150new'

let g:ale_disable_lsp = 1
let g:ale_sign_error = ' ✗'
let g:ale_sign_warning = ' ⚠'
let g:ale_set_balloons = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fix_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
highlight ALEWarningSign cterm=bold ctermfg=222 ctermbg=235
highlight ALEErrorSign cterm=bold ctermfg=1 ctermbg=235


" Search word under cursor
nmap gs :Ag <c-r><c-w><CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>cf <Plug>(coc-fix-current)

" Useful for 'get varible type under cursor'
nmap <leader>d :call CocAction('doHover')<CR>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

nnoremap <leader>u :UndotreeShow<CR>

" autocmd CursorHold * silent call CocActionAsync('highlight')

" inoremap <expr> <cr>umvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" " Or use `complete_info` if your vim support it, like:
" " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" :
" " "\<C-g>u\<CR>"
"

let g:gitgutter_max_signs = 1000

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='bubblegum'

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

highlight Directory ctermfg=113

" FZF
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" Make Ctrl-W works as 'del prev word' in fzf-window
autocmd FileType fzf set termwinkey=<C-L>

" let $FZF_DEFAULT_OPTS='--reverse'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bar -bang -nargs=? -complete=buffer Buffers
    \ call fzf#vim#buffers(<q-args>, {}, <bang>0)

function! PreventBuffersInNERDTree()
  if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
    \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
    \ && &buftype == '' && !exists('g:launching_fzf')
    let bufnum = bufnr('%')
    close
    exe 'b ' . bufnum
    NERDTree " restore nerdtree
	wincmd w " jump to file split from nerdtree
  endif
  if exists('g:launching_fzf') | unlet g:launching_fzf | endif
endfunction
autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
autocmd BufWinEnter * call PreventBuffersInNERDTree()


" Markdown-preview
let g:mkdp_open_to_the_world = 1
let g:mkdp_echo_preview_url = 1

" EasyMotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to line
map <Leader>j <Plug>(easymotion-bd-jk)
nmap <Leader>j <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>f <Plug>(easymotion-bd-w)
nmap <Leader>f <Plug>(easymotion-overwin-w)

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)
let g:easy_align_delimiters = { '\': { 'pattern': '\\' } }

autocmd Filetype vue setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
