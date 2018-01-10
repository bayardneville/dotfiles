" General
set clipboard^=unnamed

" Config editing shortcuts
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>eb :vsplit ~/.bashrc<CR>
nnoremap <leader>ez :vsplit ~/.zshrc<CR>
nnoremap <leader>et :vsplit ~/.tmux.conf<CR>
nnoremap <leader>rv :source $MYVIMRC<CR>

" Colorscheme
colorscheme solarized
set background=dark
set term=screen-256color
syntax enable

" Indentation
filetype plugin indent on
set autoindent
set expandtab
set shiftround
set softtabstop=-1

augroup Indentation
  autocmd!
  autocmd FileType * setlocal shiftwidth=2
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType make let &l:shiftwidth=&tabstop|setlocal noexpandtab
augroup END

augroup LineLength
    autocmd!
    autocmd WinEnter,BufEnter * call clearmatches() | call matchadd('ErrorMsg', '\%101v', -1)
    autocmd WinEnter,BufEnter *.rb call clearmatches() | call matchadd('ErrorMsg', '\%121v', -1)
augroup END

augroup Linting
  autocmd FileType python setlocal makeprg=flake8\ --radon-max-cc\ 5
  autocmd FileType ruby setlocal makeprg=rubocop\ --format=emacs
  autocmd BufWritePost *.py,*.rb silent make! <afile> | silent redraw!
  autocmd QuickFixCmdPost [^l]* cwindow
augroup END

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
set scrolloff=1
set number relativenumber
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list

augroup NumberToggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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

" juggling with tags
nnoremap <leader>j :tjump /
nnoremap <leader>p :ptjump /

" Autocomplete
set complete+=d
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Wild
set wildmenu
set wildmode=full
set wildignorecase
set wildignore+=*.pyc
set wildcharm=<C-z>

" File re-loading
set autoread
augroup FileReload
  autocmd!
  autocmd BufEnter,BufLeave,FocusGained,FocusLost,InsertEnter,InsertLeave * checktime
augroup END

" Unsorted
set backspace=indent,eol,start
set hidden
set mouse=a
set pastetoggle=<F12>
set noswapfile
set tags=./tags;,tags;,.tags;

" Fix mouse interaction with splits in tmux
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

" This is built in so why not?
runtime macros/matchit.vim

" smooth searching
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"
