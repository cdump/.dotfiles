set nocompatible    " Be improved
language C          " Show VIM messages in English
let mapleader = "\<Space>"


" =============== Plugins Initialization ===============
source ~/.vim/plugins.vim


" =============== General ===============
syntax on           " Enable syntax highlighting
set autowrite       " Automatically save before commands like :next and :make
set confirm         " Raise a dialogue asking if you wish to save changed files
set autoread        " Reload unchanged buffers when file changed outside vim
set cursorline      " Higlight current line
set hidden          " Hides buffer with unsaved changes
set history=1000    " Store lots of :cmdline history
"set nostartofline   " Stop certain movements from always going to the first character of a line

set wrap            " Wrap long lines
set linebreak       " Do not break the words
set whichwrap+=<,>,h,l,[,]  " Automatically wrap left and right

set number          " Line numbers are good
set updatetime=300
set ttimeoutlen=50  " Make Esc work faster
set scrolloff=5     " Minimal number of screen lines to keep above and below the cursor.

set laststatus=2    " Show status line on the last window
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set wildignore+=*.o,*.tmp,*.swp,*~,.git
set wildmenu        " Enable wildmenu
set wildmode=longest:full,full
set backspace=indent,eol,start  " proper backspacing
set nrformats-=octal    " 0-prefixed numbers are still decimal

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


" =============== Colors & Style ===============
if has('nvim')
    set termguicolors " 24bit colors in terminal
end
silent! colorscheme molokai

" highlight Directory ctermfg=113 guifg=#FFd75f
" highlight ALEWarningSign cterm=bold ctermfg=222 ctermbg=235
" highlight ALEErrorSign cterm=bold ctermfg=1 ctermbg=235

" highlight LspDiagnosticsSignWarning cterm=bold ctermfg=222 ctermbg=235
" highlight LspDiagnosticsSignError cterm=bold ctermfg=1 ctermbg=235
" highlight link DiagnosticError LspDiagnosticsSignError

" '|' cursor in insert mode
let &t_SI.="\e[6 q"
let &t_SR.="\e[2 q"
let &t_EI.="\e[2 q"

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif


" ============== FileType-specific configuration =====================
" autocmd Filetype vue setlocal ts=2 sw=2 expandtab
" autocmd Filetype javascript setlocal ts=2 sw=2 expandtab


" ============== Mappings =====================
" Clear current search highlight
nnoremap <silent> // :nohlsearch<CR>

inoremap <C-c> <Esc>

" Alt-N switch to Nth tab
for c in range(char2nr('0'), char2nr('9'))
    let n = nr2char(c)
    let k = has('nvim') ? ('<M-' . n . '>') : ('' . n)
    execute 'map ' . k . ' <Plug>AirlineSelectTab' . n . '<CR>'
endfor

cabbrev W w
cabbrev Q q
cabbrev WQ wq
cabbrev Wq wq

" Save
nmap <Leader>s :update<CR>

" Toggle relativenumbers
nnoremap <Leader><Leader>r :set relativenumber!<CR>

" Toggle Cursor Column
nnoremap <silent> <leader>v :set cursorcolumn!<CR>

" HardMode
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

nnoremap <leader>a :Ag<Space>
" Search word under cursor
nmap gs :Ag <c-r><c-w><CR>

" Close current buffer or vim
function! Bye()
     if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
         :quit
     else
         :bprevious|bdelete #
    endif
endfunction
nnoremap <silent> <leader>q :call Bye()<CR>


" ================ Splits =================
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
nnoremap <C-w>+ <C-w>+<SID>ws
nnoremap <C-w>- <C-w>-<SID>ws
nnoremap <C-w>> <C-w>><SID>ws
nnoremap <C-w>< <C-w><<SID>ws
nnoremap <script> <SID>ws+ <C-w>+<SID>ws
nnoremap <script> <SID>ws- <C-w>-<SID>ws
nnoremap <script> <SID>ws> <C-w>><SID>ws
nnoremap <script> <SID>ws< <C-w><<SID>ws
nnoremap <SID>ws <Nop>


" ================ Movements =================
" Jump to line
nmap <Leader>j <Plug>(easymotion-bd-jk)
nmap <Leader>j <Plug>(easymotion-overwin-line)

" Move to word
nmap <Leader>f <Plug>(easymotion-bd-w)
nmap <Leader>f <Plug>(easymotion-overwin-w)


" EasyAlign
vmap <Enter> <Plug>(EasyAlign)

" Open the project tree and expose current file in the nerdtree with Ctrl-\
nnoremap <silent> <C-\> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" ================ FZF =================
noremap <c-p> :Files<CR>
noremap <leader>b :Buffers<CR>

if !has('nvim')
    " Make Ctrl-W works as 'del prev word' in fzf-window
    autocmd FileType fzf set termwinkey=<C-L>
endif

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
    execute 'b ' . bufnum
    NERDTree " restore nerdtree
	wincmd w " jump to file split from nerdtree
  endif
  if exists('g:launching_fzf') | unlet g:launching_fzf | endif
endfunction
autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
autocmd BufWinEnter * call PreventBuffersInNERDTree()


" ================ Code Completion / LSP / Linters =================
" Ale linters
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap <silent><C-k> :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent><C-j> :Lspsaga diagnostic_jump_next<CR>

nnoremap <leader>so :SymbolsOutline<CR>

" Coc
" nnoremap <silent> gd <Plug>(coc-definition)
" nnoremap <silent> gi <Plug>(coc-implementation)
" nnoremap <silent> gr <Plug>(coc-references)
" nnoremap <leader>rn <Plug>(coc-rename)
" nnoremap <leader>cf <Plug>(coc-fix-current)
" " Useful for 'get varible type under cursor'
" nnoremap <leader>d :call CocAction('doHover')<CR>

nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>rn :Lspsaga rename<CR>
" nnoremap <leader>cf :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>ca :Lspsaga code_action<CR>
vnoremap <leader>ca :<C-U>Lspsaga range_code_action<CR>
" Useful for 'get varible type under cursor'
nnoremap <leader>d :lua vim.lsp.buf.hover()<CR>

nnoremap <silent>gh :Lspsaga lsp_finder<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

if has('nvim')
inoremap <expr> <CR> compe#confirm('<CR>')
lua <<EOF
local function lsp_setup_servers()
    local lspi = require 'lspinstall'

    -- lspi.install_server('python')

    lspi.setup()
    local servers = lspi.installed_servers()
    table.insert(servers, "clangd")
    for _, server in pairs(servers) do
        local caps = vim.lsp.protocol.make_client_capabilities()
        caps.textDocument.completion.completionItem.snippetSupport = true
        caps.textDocument.completion.completionItem.resolveSupport = {
          properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
          }
        }
        local cfg = {capabilities = caps}
        if server == "clangd" then
            cfg.cmd = {'/usr/bin/clangd', '--background-index', '--clang-tidy'}
        elseif server == "python" then
            cfg.settings = {python={pythonPath='.venv/bin/python'}}
        end
        require'lspconfig'[server].setup(cfg)
    end
end


lsp_setup_servers()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text=false,underline=false})

require'lspsaga'.init_lsp_saga{
    error_sign=' ✗',
    warn_sign=' ⚠',
    hint_sign='',
    infor_sign='',
    code_action_keys={quit='<C-c>'},
    finder_action_keys={quit='<C-c>'},
    border_style='round'
}

require'compe'.setup {
    source = {
        path = true,
        buffer = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        vsnip = false,
        ultisnips = true,
        luasnip = false,
        emoji = false,
    };
}

vim.g.symbols_outline = {
    keymaps = {
        close = "<C-c>",
    }
}
EOF
endif " has(nvim)
