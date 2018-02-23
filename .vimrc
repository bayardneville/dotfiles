" FILETYPE
filetype plugin indent on
syntax on

packadd matchit

" SETTINGS
set autoindent
set autoread
set backspace=indent,eol,start
set complete+=d
set cursorline
set expandtab
set grepprg=grep\ -rnsHI\ --exclude=.tags\ --exclude-dir=log
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set mouse=a
set noswapfile
set number
set path=.,**
set ruler
set scrolloff=1
set shiftround
set showcmd
set showmatch
set showmode
set smartcase
set softtabstop=-1
set splitbelow
set splitright
set tags=./tags;,tags;,.tags;
set ttymouse=sgr
set wildcharm=<C-z>
set wildignore+=tags,.tags,*.pyc
set wildignorecase
set wildmenu

" MAPPINGS

" scroll visually through wrapped lines
nnoremap j gj
nnoremap k gk

map <space> \
map <leader><space> :nohlsearch<CR>

" config
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>eb :vsplit ~/.bashrc<CR>
nnoremap <leader>rv :source $MYVIMRC<CR>

" mark
nnoremap ' `
nnoremap ` '

" file
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

" buffer
nnoremap gb :ls<CR>:buffer<space>
nnoremap gB :ls<CR>:sbuffer<space>
nnoremap <leader>b :buffer *
nnoremap <leader>B :sbuffer *

" tag
nnoremap <leader>j :tjump /
nnoremap <leader>p :ptjump /

" terminal
nnoremap <leader>c :vert term<CR>

" tab through autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" tab through results while searching
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

" grep
command! -nargs=+ -complete=file_in_path -bar Grep silent! grep! <args> | redraw!
nnoremap <leader>g :Grep<space>

" AUTOCOMMANDS
augroup Indentation
  autocmd!
  autocmd FileType * setlocal shiftwidth=2
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType make let &l:shiftwidth=&tabstop|setlocal noexpandtab
augroup END

augroup LineLength
  autocmd!
  autocmd FileType python setlocal colorcolumn=101
  autocmd FileType ruby setlocal colorcolumn=121
augroup END

augroup Linting
  autocmd!
  autocmd FileType python setlocal makeprg=flake8\ --radon-max-cc\ 5
  autocmd FileType ruby setlocal makeprg=rubocop\ --format=emacs
  autocmd BufWritePost *.py,*.rb silent make! <afile> | silent redraw!
  autocmd QuickFixCmdPost [^l]* cwindow
augroup END

augroup FileReload
  autocmd!
  autocmd BufEnter,BufLeave,FocusGained,FocusLost,InsertEnter,InsertLeave * checktime
augroup END

" COLORSCHEME
colorscheme apprentice
