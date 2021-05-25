call plug#begin('~/.vim/plugged')

" Libs
" Plug 'tomtom/tlib_vim'
" sets up bindings other plugins can use to make their commands repeatable with the . command
Plug 'tpope/vim-repeat'

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Allows you to explore filesystem and to open files and directories
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }
" Plug 'justinmk/vim-dirvish'

" Highlight several words in different colors simultaneously
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'

" An extensible & universal comment plugin that also handles embedded filetypes
Plug 'tomtom/tcomment_vim'

" Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'

" Support for textual snippets (used by coc-snippets)
Plug 'honza/vim-snippets'

" Vim motion on speed!
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings
Plug 'Lokaltog/vim-easymotion'

" Shows a git diff in the 'gutter' (sign column)
Plug 'airblade/vim-gitgutter'
" Best Git wrapper of all time
Plug 'tpope/vim-fugitive'

" A simple, easy-to-use alignment plugin
Plug 'junegunn/vim-easy-align'

" Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" :CocInstall coc-python
" :CocInstall coc-snippets
" :CocInstall coc-yaml
" :CocInstall coc-json

" Better Rainbow Parentheses
let g:rainbow_active = 1
let g:rainbow_conf = {'separately': { 'nerdtree': 0 } }
Plug 'luochen1990/rainbow'

" Allows to configure % to match more than just single characters
Plug 'vim-scripts/matchit.zip'

" Causes all trailing whitespace characters (spaces and tabs) to be highlighted
Plug 'ntpeters/vim-better-whitespace'

" Go (golang) support for Vim
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

" multiple selections for Vim
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

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
Plug 'ryanoasis/vim-devicons'

" Asynchronous Lint Engine
Plug 'dense-analysis/ale'

" Themes
Plug 'tomasr/molokai'

" Visualizes undo history and makes it easier to browse and switch between different undo branches
Plug 'mbbill/undotree'

"Plug 'puremourning/vimspector'

call plug#end()
