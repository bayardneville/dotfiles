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
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣,trail:·
set mouse=a
set noswapfile
set path=.,,**
set ruler
set scrolloff=1
set shiftround
set showcmd
set showmatch
set showmode
set smartcase
set softtabstop=-1
set tags=./tags;
set ttymouse=sgr
set wildcharm=<c-z>
set wildignore+=tags,*.pyc,*/__pycache__/,*_py.html,*/venv/*
set wildignorecase
set wildmenu

" gutentags exludes wildignore from tags by default, but */venv/* does not
" match venv in project root for ctags excludes since * does not match empty
let g:gutentags_project_root = ['venv']

" MAPPINGS

" scroll visually through wrapped lines
nnoremap j gj
nnoremap k gk

map <space> \
map <leader>h :nohlsearch<cr>

" prioritize jump to exact mark
nnoremap ' `
nnoremap ` '

" file
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *

" buffer
nnoremap <leader>b :buffer *
nnoremap <leader>B :sbuffer *

" tag
nnoremap <leader>t :tjump /
nnoremap <leader>p :ptjump /
nnoremap <leader>T :tjump <c-r><c-w><cr>
nnoremap <leader>P :ptjump <c-r><c-w><cr>

" jump directly to tag for one match otherwise show list
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" quickfix list navigation
nnoremap <leader>j :cnext<cr>
nnoremap <leader>k :cprevious<cr>

" location list navigation
nnoremap <leader>J :lnext<cr>
nnoremap <leader>K :lprevious<cr>

" grep
nnoremap <leader>g :Grep<space>
nnoremap <silent> <leader>G :Grep<space> <c-r><c-w><cr>
xnoremap <silent> ,G :<c-u>let cmd = "Grep " . visual#GetSelection() <bar>
                        \ call histadd("cmd", cmd) <bar>
                        \ execute cmd<cr>
" this does NOT allow passing of additional flags to grepprg
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr system(&grepprg . ' ''<args>''')

" quick search replace
" paragraph
nnoremap <leader>r :'{,'}s/\<<c-r>=expand('<cword>')<cr>\>/
" file
nnoremap <leader>R :%s/\<<c-r>=expand('<cword>')<cr>\>/

" replace occurrences of word under cursor (repeat with .)
" forward
nnoremap <leader>; *``cgn
" backward
nnoremap <leader>, #``cgN

" git
command! -range GB echo join(systemlist("git -C " . shellescape(expand('%:p:h')) . " blame -L <line1>,<line2> " . expand('%:t')), "\n")
" open current file in github on master/main branch
command! GH echo system("open https://$(git remote -v  | sed -rn -e '1s#.*@(.*:.*)\\.git.*#\\1#' -e '1s#:#/#p')/blob/$(if git show-ref --verify --quiet refs/heads/master; then echo master; else echo main; fi)/$(git -C " . shellescape(expand('%:p:h')) . " ls-files --full-name " . expand('%:t') . ")#L" . line('.'))

" AUTOCOMMANDS
augroup Indentation
  autocmd!
  autocmd FileType * setlocal shiftwidth=2
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType python let g:pyindent_open_paren='shiftwidth()'
  " autocmd FileType python let g:pyindent_nested_paren='shiftwidth()'
  " autocmd FileType python let g:pyindent_continue='shiftwidth()'
  autocmd FileType python let g:pyindent_continue='0'
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

" commented out since conflicts with vim-qf, TODO: disable when vim-qf is detected
" automatically open location/quickfix window when populated
" augroup Quickfix
"   autocmd!
"   autocmd QuickFixCmdPost [^l]* cwindow
"   autocmd QuickFixCmdPost l* lwindow
" augroup END

" reload file on various common triggers to pick up external changes
augroup FileReload
  autocmd!
  autocmd BufEnter,BufLeave,FocusGained,FocusLost,InsertEnter,InsertLeave * checktime
augroup END

" COLORSCHEME
colorscheme apprentice
