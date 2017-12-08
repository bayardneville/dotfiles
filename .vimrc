" General
set nocompatible

" Config editing shortcuts
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>

" Colorscheme
colorscheme solarized
set background=dark
set term=screen-256color
syntax enable

" Indentation
filetype indent on
set shiftwidth=2
set autoindent
set expandtab
set shiftround
set softtabstop=2

" Map space to leader so it still shows up in showcmd
map <space> \

" Split navigation shortcuts
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" More natural split opening
set splitbelow
set splitright

" Scroll visually through wrapped lines
nnoremap j gj
nnoremap k gk

" Searching
set incsearch
set hlsearch
set smartcase
set ignorecase
map <leader><space> :nohlsearch<CR>

" Display
set showmatch
set cursorline
set showcmd
set showmode
set lazyredraw
set laststatus=2
set ruler
set number


set backspace=2
set mouse=a
set pastetoggle=<F12>
set scrolloff=4
set wildmenu

