" General
set clipboard=unnamed
inoremap jk <esc>
xnoremap jk <esc>

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
set autoindent

augroup FileIndentation
  autocmd FileType * set shiftwidth=2|let &softtabstop=&shiftwidth|set colorcolumn=121
  autocmd FileType python set shiftwidth=4|let &softtabstop=&shiftwidth|set colorcolumn=101
augroup END

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
set path=.,**
nnoremap gb :ls<CR>:b<space>
nnoremap <leader>b :buffer *
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>

" Wild
set wildmenu
set wildmode=list:full
set wildignorecase

" Unsorted
set backspace=indent,eol,start
set hidden
set mouse=a
set pastetoggle=<F12>
set scrolloff=4

" Fix mouse interaction with splits in tmux
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

" This is built in so why not? 
runtime macros/matchit.vim

