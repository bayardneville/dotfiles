set nocompatible

set t_Co=16

syntax on

set backspace=2

set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set autoindent
filetype indent on

set pastetoggle=<F12>
set showmode

set number
hi LineNr ctermfg=lightgreen ctermbg=black
set cursorline
hi CursorLine cterm=none ctermbg=black
hi CursorLineNR cterm=bold ctermfg=lightgreen ctermbg=black

set ruler
set showcmd
set wildmenu
set lazyredraw
set mouse=a

set scrolloff=4

set showmatch
hi MatchParen cterm=none ctermfg=darkgrey ctermbg=red

set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <space> :nohlsearch<CR>

" Scroll visually through wrapped lines
nnoremap j gj
nnoremap k gk

