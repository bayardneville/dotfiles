" FILETYPE
filetype plugin indent on
syntax on

packadd matchit

" SETTINGS
set autoindent
set autoread
set backspace=indent,eol,start
set clipboard^=unnamed
set complete+=d
set cursorline
set expandtab
set grepprg=ag\ --vimgrep
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
set path=.,**
set ruler
set scrolloff=1
set shiftround
set showcmd
set showmatch
set showmode
set smartcase
set softtabstop=-1
set tags=./tags;,tags;
set ttymouse=sgr
set wildcharm=<C-z>
set wildignore+=tags,*.pyc,*_py.html
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
" nnoremap <leader>j :tjump /
" nnoremap <leader>p :ptjump /

" terminal
nnoremap <leader>c :vert term<CR>

" quickfix
nnoremap <leader>j :cnext<CR>
nnoremap <leader>k :cprevious<CR>

" grep
nnoremap <silent> <leader>g :Grep<space>
nnoremap <leader>G :Grep<space> <c-r><c-w><cr>
xnoremap <silent> ,G :<C-u>let cmd = "Grep " . visual#GetSelection() <bar>
                        \ call histadd("cmd", cmd) <bar>
                        \ execute cmd<CR>
" this does NOT allow passing of additional flags to grepprg
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr system(&grepprg . ' ''<args>''')

" git
command! -range GB echo join(systemlist("git -C " . shellescape(expand('%:p:h')) . " blame -L <line1>,<line2> " . expand('%:t')), "\n")

" AUTOCOMMANDS
augroup Indentation
  autocmd!
  autocmd FileType * setlocal shiftwidth=2
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType python let g:pyindent_open_paren='shiftwidth()'
  " autocmd FileType python let g:pyindent_continue='shiftwidth()'
  autocmd FileType make let &l:shiftwidth=&tabstop|setlocal noexpandtab
augroup END

augroup LineLength
  autocmd!
  autocmd FileType python setlocal colorcolumn=101
  autocmd FileType ruby setlocal colorcolumn=121
augroup END

" specify language specific linters to populate the location list on save
augroup Linting
  autocmd!
  autocmd FileType python setlocal makeprg=flake8\ --append-config\ ~/.config/flake8
  autocmd FileType ruby setlocal makeprg=rubocop\ --format=emacs
  autocmd BufWritePost *.py,*.rb lgetexpr system(&makeprg . ' ' . expand('<afile>'))
augroup END

" automatically open location/quickfix window when populated
augroup Quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

" reload file on various common triggers to pick up external changes
augroup FileReload
  autocmd!
  autocmd BufEnter,BufLeave,FocusGained,FocusLost,InsertEnter,InsertLeave * checktime
augroup END

" COLORSCHEME
colorscheme apprentice
