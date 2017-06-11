" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" TODO: search
set ignorecase
set smartcase
set incsearch
set hlsearch

" TODO: edit
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
if has('unnamedplus')
  " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
  set clipboard& clipboard+=unnamedplus,unnamed 
else
  " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
  set clipboard& clipboard+=unnamed
endif
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
set cursorline
" set cursorcolumn
set wrap
set textwidth=0
set visualbell t_vb=
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" TODO: key-config
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

nnoremap <Tab> %
vnoremap <Tab> %

vnoremap v $h

" TODO: ctags keybind
nnoremap <C-]> g<C-]>

" split
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-x> <C-w>x

" change window position
nnoremap <C-w><C-h> <C-w>H
nnoremap <C-w><C-j> <C-w>J
nnoremap <C-w><C-k> <C-w>K
nnoremap <C-w><C-l> <C-w>L

" change window size
nnoremap <S-Left> <C-w><
nnoremap <S-Right> <C-w>>
nnoremap - <C-w>-
nnoremap + <C-w>+

" no high-light
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" make, grep -> QuickFix
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFix, Help close window: q
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" memo
nmap <F6> :e ~/memo.txt<CR>

" TODO: neobundle settings
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'

if !isdirectory(s:neobundle_root) || v:version < 702
  let s:noplugin = 1
else
  if has('vim_starting')
    " Required:
    execute "set runtimepath+=" . s:neobundle_root
  endif

  " Required:
  call neobundle#begin(s:bundle_root)

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle "Shougo/vimproc", {
    \ "build": {
    \   "windows"   : "make -f make_mingw32.mak",
    \   "cygwin"    : "make -f make_cygwin.mak",
    \   "mac"       : "make -f make_mac.mak",
    \   "unix"      : "make -f make_unix.mak",
    \ }}

  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'flazz/vim-colorschemes'

  " You can specify revision/branch/tag.
  NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

  " TODO: plugin list
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'kien/ctrlp.vim'
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'kannokanno/previm'
  " NeoBundle 'tpope/vim-surround'
  NeoBundle 'gregsexton/gitv'
  NeoBundle 'tpope/vim-fugitive'
  
  "NeoBundle 'vim-scripts/wombat'
  "NeoBundle 'vim-scripts/rdark-terminal'
  "NeoBundle 'w0ng/vim-hybrid'
  "NeoBundle 'NLKNguyen/papercolor-theme'
  NeoBundle 'cocopon/lightline-hybrid.vim'
  "NeoBundle 'chriskempson/tomorrow-theme'
  "NeoBundle 'ciaranm/inkpot'
  "NeoBundle 'tomasr/molokai'
  "NeoBundle 'cocopon/iceberg.vim'
  NeoBundle 'jonathanfilip/vim-lucius'

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.

  " TODO: VimShell key-config
  nnoremap <F10> :VimShellTab<CR>
  
  " TODO: YankRing.vim settings
  NeoBundle 'vim-scripts/YankRing.vim'
  let g:yankring_history_dir = '~/.vim/yankring'
  nmap <F9> :YRShow<CR>
  
  " TODO: lightline settings
  let g:lightline = {
    \ 'mode_map': {'c': 'NORMAL'},
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'modified': 'MyModified',
    \   'readonly': 'MyReadonly',
    \   'fugitive': 'MyFugitive',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode'
    \ }}
  
  let g:lightline.colorscheme = 'hybrid'
  
  function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction
  
  function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
  endfunction
  
  function! MyFugitive()
    try
      if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
      endif
    catch
    endtry
    return ''
  endfunction
  
   function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
      \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
      \  &ft == 'unite' ? unite#get_status_string() :
      \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
      \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction
  
  function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction
  
  function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction
  
  function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction
  
  function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
  endfunction
  
  NeoBundleLazy 'Shougo/neosnippet.vim', { "autoload": {"insert": 1}}
  NeoBundleLazy 'mattn/emmet-vim', { "autoload": {"filetypes": ['html']}}
  
  " TODO: tagbar settings
  NeoBundleLazy 'majutsushi/tagbar', {
    \ 'autoload': {
    \   'commands': ['TagbarToggle'],
    \ },
    \ 'build': {
    \   'mac': 'brew install ctags',
    \ }}
  nmap <F3> :TagbarToggle<CR>
  
  " TODO: vim-template settings
  NeoBundle "thinca/vim-template"
  " テンプレート中に含まれる特定文字列を置き換える
  autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
  function! s:template_keywords()
      silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
      silent! %s/<+FILENAME+>/\=expand('%:r')/g
  endfunction
  " テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
  autocmd MyAutoCmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'
    \ | endif

  " TODO: vim-go settings
  NeoBundleLazy 'fatih/vim-go', {
              \ 'autoload' : { 'filetypes' : 'go' }
              \ }
  
  " TODO: GundoToggle settings
  NeoBundleLazy 'sjl/gundo.vim', {
    \ 'autoload': {
    \   'commands': ['GundoToggle']
    \ }}
  nmap <F8> :GundoToggle<CR>
  
  " TODO: TaskList settings
  NeoBundleLazy 'vim-scripts/TaskList.vim', {
    \ 'autoload': {
    \   'mappings': ['<Plug>TaskList'], 
    \ }}
  nmap <F6> <Plug>TaskList
  
  " TODO: Unite settings
  NeoBundleLazy 'Shougo/unite.vim', {
    \ "autoload": {
    \   "commands": ["Unite", "UniteWithBufferDir"]
    \ }}
  NeoBundleLazy 'h1mesuke/unite-outline', {
        \ "autoload": {
        \   "unite_sources": ["outline"],
        \ }}
  nnoremap [unite] <Nop>
  nmap U [unite]
  nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]r :<C-u>Unite register<CR>
  nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
  nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
  nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
  nnoremap <silent> [unite]T :<C-u>Unite tweetvim<CR><Esc>
  nnoremap <silent> [unite]w :<C-u>Unite window<CR>
  let s:hooks = neobundle#get_hooks("unite.vim")
  function! s:hooks.on_source(bundle)
    " start unite in insert mode
    let g:unite_enable_start_insert = 1
    " use vimfiler to open directory
    call unite#custom_default_action("source/bookmark/directory", "vimfiler")
    call unite#custom_default_action("directory", "vimfiler")
    call unite#custom_default_action("directory_mru", "vimfiler")
    autocmd MyAutoCmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      imap <buffer> <Esc><Esc> <Plug>(unite_exit)
      nmap <buffer> <Esc> <Plug>(unite_exit)
      nmap <buffer> <C-n> <Plug>(unite_select_next_line)
      nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
    endfunction
  endfunction
  
  " TODO: vimfiler settings
  NeoBundleLazy 'Shougo/vimfiler', {
    \ "depends": ['Shougo/unite.vim'],
    \ "autoload": {
    \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
    \   "mappings": ['<Plug>(vimfiler_switch)'],
    \   "explorer": 1,
    \ }}
  nnoremap <F2> :VimFilerExplorer<CR>
  
  " TODO: neocomplete settings
  if has('lua') && v:version >= 704
    NeoBundleLazy 'Shougo/neocomplete.vim', {
      \ "autoload": {
      \   "insert": 1,
      \ }}
    
    let g:neocomplete#enable_at_startup = 1
    let s:hooks = neobundle#get_hooks("neocomplcache.vim")
    function! s:hooks.on_source(bundle)
      let g:acp_enableAtStartup = 0
      let g:neocomplete#enable_smart_case = 1
    endfunction
  else
    NeoBundleLazy "Shougo/neocomplcache.vim", {
      \ "autoload": {
      \   "insert": 1,
      \ }}
    let g:neocomplcache_enable_at_startup = 1
    let s:hooks = neobundle#get_hooks("neocomplcache.vim")
    function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplcache_enable_smart_case = 1
    endfunction
  endif
  
  " complimentation list toggle TAB, S-TAB
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
  
  " TODO: QuickRun settings
  NeoBundleLazy "thinca/vim-quickrun", {
    \ "autoload": {
    \   "mappings": [['nxo', '<Plug>(quickrun)']]
    \ }}
  nmap <F5> <Plug>(quickrun)
  set splitright
  let s:hooks = neobundle#get_hooks("vim-quickrun")
  
  " TODO: vim-indent-guides
  NeoBundle "nathanaelkane/vim-indent-guides"
  let g:indent_guides_enable_on_vim_startup = 1 " 2013-06-24 10:00 削除
  " let s:hooks = neobundle#get_hooks("vim-indent-guides")
  function! s:hooks.on_source(bundle)
     let g:indent_guides_guide_size = 1
  endfunction
  
  " TODO: syntastic settings
  NeoBundle "scrooloose/syntastic"
  
  " TODO: clang_complete
  " NeoBundleLazy 'Rip-Rip/clang_complete', { "autoload": { "filetypes": ['c', 'cpp']}}
  " let g:clang_jumpto_declaration_key = '<C-t>'
  
  " c++11 compiler settings
  if executable('clang++')
    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_cpp_compiler_options = '-std=c++0x -stdlib=libc++'
    let g:quickrun_config = {}
    let g:quickrun_config['cpp/c++0x'] = {
      \ 'command': 'clang++',
      \ 'cmdopt': '-std=c++0x -Wall -O3',
      \ 'type': 'cpp/c++0x'
      \ }
    let g:quickrun_config['cpp'] = {'type': 'cpp/c++0x'}
    "let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib'
    "let g:clang_user_options = '-std=c++0x -stdlib=libc++'
  elseif executable('g++')
    let g:syntastic_cpp_compiler = 'g++'
    let g:syntastic_cpp_compiler_options = '-std=c++0x -stdlib=libc++'
    let g:quickrun_config = {}
    let g:quickrun_config['cpp/c++0x'] = {
      \ 'command': 'g++',
      \ 'cmdopt': '-std=c++0x -Wall -O3',
      \ 'type': 'cpp/c++0x'
      \ }
    let g:quickrun_config['cpp'] = {'type': 'cpp/c++0x'} 
    " let g:clang_library_path = '/opt/local/usr/lib'
    " let g:clang_user_options = '-std=c++0x -stdlib=libc++'
  endif
  
  " markdown settings
  NeoBundleLazy 'plasticboy/vim-markdown', {"autoload": {"filetypes": ['markdown']}} 
  
  " haskell plugin
  " NeoBundleLazy 'kana/vim-filetype-haskell', { "autoload": { "filetypes": ['haskell'] }}
  " NeoBundleLazy 'eagletmt/ghcmod-vim', { "autoload": { "filetypes": ['haskell'] }}
  " NeoBundleLazy 'ujihisa/neco-ghc', { "autoload": { "filetypes": ['haskell'] }}
  " NeoBundleLazy 'osyo-manga/vim-watchdogs', { "autoload": { "filetypes": ['haskell'] }}
  
  " correspond markdown
  autocmd BufNewFile,BufRead *.md :set filetype=markdown
  autocmd BufNewFile,BufRead *.md :set syntax=markdown
  
  call neobundle#end()
  NeoBundleCheck

endif

" Required:
filetype plugin indent on

" TODO: colorscheme
set background=dark
" colorscheme iceberg
" colorscheme rdark-terminal
" colorscheme hybrid
" colorscheme wombat
" colorscheme Tomorrow-Night
colorscheme molokai
" colorscheme inkpot
" colorscheme lucius
" colorscheme PaperColor
" LuciusBlack

"hi CursorLine term=underline cterm=underline guibg=NONE
"hi CursorLineNr ctermfg=7
"hi LineNr ctermbg=0 ctermfg=6
"hi clear CursorLine
