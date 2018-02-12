" reset augroup
augroup MyAutoCmd
  autocmd!
augroup End

" {{{ dein

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

let g:python3_host_prog = $PYENV_ROOT . '/versions/3.6.4/bin/python'

let s:dein_dir = expand('$DATA/dein')

if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

    " Auto Download
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif

    execute 'set runtimepath^=' . s:dein_repo_dir
endif


" dein.vim settings

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir = expand('$CONFIG/dein')

    call dein#load_toml(s:toml_dir . '/plugins.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})
    if has('python3')
        call dein#load_toml(s:toml_dir . '/python.toml', {'lazy': 1})
    endif

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif
" }}}

" {{{ general config

" search
set ignorecase
set smartcase
set incsearch
set hlsearch

" edit
" set foldmethod=syntax
" set foldcolumn=3
set tabstop=4
set autoindent
set noexpandtab
set shiftwidth=4
set shiftround
set infercase
set virtualedit=all
set hidden
set switchbuf=useopen
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start
set nowritebackup
set nobackup
set noswapfile
if has('mac')
  set noundofile
endif

" TODO: displays
syntax on
set t_Co=256
set laststatus=2
set list
set number
set wrap
set textwidth=0
set visualbell t_vb=
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" folding settings
au FileType vim setlocal foldmethod=marker

" make, grep -> QuickFix
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFix, Help close window: q
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" }}}

" {{{ key-config
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap jj <ESC>
tnoremap jj <C-\><C-n>

nnoremap <Tab> %
vnoremap <Tab> %

vnoremap v $h

" ctags keybind
nnoremap <C-]> g<C-]>

" split
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-x> <C-w>x

" change window size
nnoremap <S-Left> <C-w><
nnoremap <S-Right> <C-w>>
nnoremap - <C-w>-
nnoremap + <C-w>+

" no high-light
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" }}}

" {{{ color scheme settings
set background=dark
colorscheme molokai
set cursorline
" highlight CursorLine term=underline cterm=underline ctermfg=NONE ctermbg=NONE
" highlight CursorLineNr ctermfg=7
" highlight LineNr ctermbg=0 ctermfg=6
" }}}
