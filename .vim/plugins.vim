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

" Display tags in a window, ordered by class etc.
" Plug 'majutsushi/tagbar'

" Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'

" Support for textual snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Vim motion on speed!
Plug 'Lokaltog/vim-easymotion'

" Interactive command execution in Vim
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Powerful shell implemented by vim
Plug 'Shougo/vimshell.vim'

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

" Toggling the display of the quickfix list and the location-list
Plug 'Valloric/ListToggle'

" Better Rainbow Parentheses
Plug 'kien/rainbow_parentheses.vim'

" Allows to configure % to match more than just single characters
Plug 'vim-scripts/matchit.zip'

" Causes all trailing whitespace characters (spaces and tabs) to be highlighted
Plug 'ntpeters/vim-better-whitespace'

" Go (golang) support for Vim
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'

Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'isRuslan/vim-es6'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" A collection of language packs for Vim, loaded only on demand
Plug 'sheerun/vim-polyglot'

Plug 'ryanoasis/vim-devicons'

" Asynchronous Lint Engine
Plug 'dense-analysis/ale'

" Themes
Plug 'tomasr/molokai'

call plug#end()
