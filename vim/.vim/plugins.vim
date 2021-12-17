call plug#begin('~/.vim/plugged')

" Libs
" Plug 'tomtom/tlib_vim'
" sets up bindings other plugins can use to make their commands repeatable with the . command
Plug 'tpope/vim-repeat'

" Lean & mean status/tabline for vim that's light as air
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='bubblegum'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Allows you to explore filesystem and to open files and directories
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }

" Highlight several words in different colors simultaneously
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'

" An extensible & universal comment plugin that also handles embedded filetypes
Plug 'tomtom/tcomment_vim'

" Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'

" Support for textual snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Vim motion on speed!
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings
Plug 'Lokaltog/vim-easymotion'

" Shows a git diff in the 'gutter' (sign column)
let g:gitgutter_max_signs = 1000
Plug 'airblade/vim-gitgutter'

" Best Git wrapper of all time
Plug 'tpope/vim-fugitive'

" A simple, easy-to-use alignment plugin
let g:easy_align_delimiters = { '\': { 'pattern': '\\' } }
Plug 'junegunn/vim-easy-align'

" Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" Better Rainbow Parentheses
let g:rainbow_active = 1
let g:rainbow_conf = {'separately': {'nerdtree': 0}, 'guifgs': ['#5fd7ff', '#ffffaf', '#afffff', '#ffd7ff']}
Plug 'luochen1990/rainbow'

" Allows to configure % to match more than just single characters
Plug 'vim-scripts/matchit.zip'

" Causes all trailing whitespace characters (spaces and tabs) to be highlighted
let g:better_whitespace_enabled=1
let g:show_spaces_that_precede_tabs=1
let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=1
let g:strip_whitespace_on_save=1
let g:better_whitespace_guicolor='#d78787'
Plug 'ntpeters/vim-better-whitespace'

" Go (golang) support for Vim
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

" multiple selections for Vim
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" General-purpose command-line fuzzy finder
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" markdown preview plugin
let g:mkdp_open_to_the_world = 1
let g:mkdp_echo_preview_url = 1
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" A collection of language packs for Vim, loaded only on demand
let g:polyglot_disabled = ['ftdetect', 'c.plugin', 'cpp.plugin']
Plug 'sheerun/vim-polyglot'

" Extended Vim syntax highlighting for C and C++
Plug 'bfrg/vim-cpp-modern'

" Adds file type icons to Vim plugins
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
Plug 'ryanoasis/vim-devicons'

" Debugger
"Plug 'puremourning/vimspector'

if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'

    Plug 'hrsh7th/nvim-compe'
    Plug 'glepnir/lspsaga.nvim'

    Plug 'simrat39/symbols-outline.nvim'
endif

" Asynchronous Lint Engine
" let g:ale_disable_lsp = 1
" let g:ale_sign_error = ' ✗'
" let g:ale_sign_warning = ' ⚠'
" let g:ale_set_balloons = 1
" let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
" let g:ale_fix_on_save = 1
" Plug 'dense-analysis/ale'

call plug#end()
