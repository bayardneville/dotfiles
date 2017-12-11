" General
set nocompatible
set clipboard=unnamed

" Config editing shortcuts
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>et :vsp ~/.tmux.conf<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>

" Colorscheme
colorscheme solarized
set background=dark
set term=screen-256color
syntax enable

" Indentation
filetype plugin indent on
autocmd FileType * set softtabstop=2|set shiftwidth=2
autocmd FileType python set softtabstop=4|set shiftwidth=4
set autoindent
set expandtab
set shiftround

" Map space to leader so it still shows up in showcmd
map <space> \

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

"  Navigation
nnoremap <leader>l :ls<CR>:b<space>
set path=.,**
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>

" Unsorted
set backspace=2
set mouse=a
set pastetoggle=<F12>
set scrolloff=4
set wildmenu

