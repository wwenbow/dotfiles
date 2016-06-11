" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
"------------------------------------------------------------------------------
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Fold vimrc
set fdm=marker

" NeoBundle Settings {{{
" Setting up NeoBundle - the vim plugin bundler

let iCanHazNeoBundle=1
if has('win32') || has('win64')
	let neobundle_readme=expand('$HOME/vimfiles/bundle/neobundle.vim/README.md')
else
	let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
endif

if !filereadable(neobundle_readme)
    echo "Installing neobundle.."
    echo ""
    if has('win32') || has('win64')
        silent !mkdir \%HOMEPATH\%\vimfiles\bundle
        silent !git clone https://github.com/Shougo/neobundle.vim \%HOMEPATH\%\vimfiles\bundle\neobundle.vim
    else
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    endif
    let iCanHazNeoBundle=0
endif

if has('win32') || has('win64')
	set runtimepath+=~/vimfiles/bundle/neobundle.vim/
	let path='~/vimfiles/bundle'
	call neobundle#begin(expand(path))
else
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	let path='~/.vim/bundle'
	call neobundle#begin(expand(path))
endif

"--------------------------------------------------------------------------}}}
" Bundles {{{
" let NeoBundle manage NeoBundle
" required!

" Choose autocompleter
if v:version <= 703
    let s:autocompleter = 'old'
elseif has('win32') || has('win64') || has('lua')
    let s:autocompleter = 'neo'
else
    let s:autocompleter = 'ycm'
endif
let g:is_exuberant = 0

" Language plugins
let g:web_dev_plugins = 1

" Overrides
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

NeoBundleFetch 'Shougo/neobundle.vim'

" My bundles here:
" original repos on GitHub
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'mbbill/undotree'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'kris89/vim-multiple-cursors'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'godlygeek/tabular' "easily make tables
NeoBundle 'tpope/vim-surround' "manipulate parenthesis
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-lua-ftplugin'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'mhinz/vim-grepper'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'tomtom/tcomment_vim'

" Web dev
" npm install tern in bundles/tern
" npm install -g jshint
if g:web_dev_plugins == 1
    NeoBundle 'mattn/emmet-vim'
    NeoBundle 'tmhedberg/matchit'
    NeoBundle 'Valloric/MatchTagAlways'
    NeoBundle 'pangloss/vim-javascript'
    NeoBundle 'othree/javascript-libraries-syntax.vim'
    NeoBundle 'marijnh/tern_for_vim', { 'build' : { 'others' : 'npm install' }, }
    NeoBundle 'moll/vim-node'
    NeoBundle 'briancollins/vim-jst'
endif


if v:version >= 703
    NeoBundle 'Lokaltog/vim-easymotion'
endif

if g:is_exuberant
    NeoBundle 'xolox/vim-easytags'
endif

" autocompleters
if s:autocompleter == 'old'
    NeoBundle 'Shougo/neocomplcache.vim'
    NeoBundle 'Shougo/neosnippet.vim'
    NeoBundle 'Shougo/neosnippet-snippets'
elseif s:autocompleter == 'neo'
    NeoBundle 'Shougo/neocomplete.vim'
    "NeoBundle 'Shougo/neosnippet.vim'
    "NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundle 'SirVer/ultisnips'
    NeoBundle 'honza/vim-snippets'
    NeoBundle 'Shougo/echodoc', '', 'default'
    call neobundle#config('echodoc', {
                \ 'lazy' : 1,
                \ 'autoload' : {
                \ 'insert' : 1,
                \ }})
    NeoBundle 'davidhalter/jedi-vim'
    NeoBundle 'derekwyatt/vim-scala'
    "NeoBundle 'osyo-manga/vim-reunions'
    "NeoBundle 'osyo-manga/vim-marching'
elseif s:autocompleter == 'ycm'
    NeoBundle 'Valloric/YouCompleteMe' , {
                \ 'build' : {
                \    'unix' : './install.py',
                \    'mac' : './install.py',
                \    },
                \ }
    NeoBundle 'SirVer/ultisnips'
    NeoBundle 'honza/vim-snippets'
endif

" Sourceforge
"NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
"
" scripts from http://vim-scripts.org/vim/scripts.html

filetype plugin indent on     " required!

NeoBundleCheck

if iCanHazNeoBundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    NeoBundleInstall
endif

call neobundle#end()
" Setting up NeoBundle - the vim plugin bundler end

"---------------------------------------------------------------------------}}}
" Colorscheme and Fonts {{{
set background=dark
colorscheme solarized
set t_Co=256
" font
if has("gui_running")
    if has("gui_macvim")
        set guifont=Source\ Code\ Pro:h11
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    elseif has("gui_gtk2")
        set guifont=Monospace\ 12
    endif
endif

"---------------------------------------------------------------------------}}}
" Features {{{
"
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

syntax on "Enable syntax highlighting

" Copy ubuntu clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

"set omnifunc=syntaxcomplete#Complete "Omni completion

if v:version >= 703
    set colorcolumn=80 "Highlight column 80, page border
endif

"set tw=79 " Wrap text at column 79
"set nowrap

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

" Auto remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Autocd to current file directory safely
" autocmd BufEnter * silent! lcd %:p:h

"---------------------------------------------------------------------------}}}
" Must have options {{{
"
set hidden
" Better command-line completion
set wildmenu
" Show partial commands in the last line of the screen
set showcmd
" Highlight searches
set hlsearch
" Incremental seatch
set incsearch

"---------------------------------------------------------------------------}}}
" Usability options {{{
"
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
" Stop certain movements from always going to the first character of a line.
set nostartofline
" Display the cursor position on the last line of the screen or in the status
set ruler
" Always display the status line, even if only one window is displayed
set laststatus=2
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Use visual bell instead of beeping when doing something wrong
set visualbell
" And reset the terminal code for the visual bell. If visualbell is set, and
set t_vb=
" Enable use of the mouse for all modes
set mouse=a
" Set the command window height to 2 lines, to avoid many cases of having to
set cmdheight=2
" Display line numbers on the left
set number
set relativenumber
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=50
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
" Natural slpit opening
set splitbelow
set splitright
" minibuffexplorer split on top
"let g:miniBufExplBRSplit=0

"---------------------------------------------------------------------------}}}
" Indentation options {{{
"
" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
" Do not push preprocessor directives left
set cinkeys-=0#
" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype lua setlocal ts=2 sw=2 expandtab

"---------------------------------------------------------------------------}}}
" Mappings {{{
"
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
map Y y$
" Map <F3> (redraw screen) to also turn off search highlighting until the
nnoremap <F8> :nohl<CR>
" NERD toggle
nnoremap <F2> :NERDTreeToggle<CR>
" Gundo toggle
nnoremap <F3> :UndotreeToggle<CR>
" Tagbar toggle
nnoremap <F4> :TagbarToggle<CR>
" Switch buffers using alt+number
nnoremap <M-1> :1b<CR>
nnoremap <M-2> :2b<CR>
nnoremap <M-3> :3b<CR>
nnoremap <M-4> :4b<CR>
nnoremap <M-5> :5b<CR>
nnoremap <M-6> :6b<CR>
nnoremap <M-7> :7b<CR>
nnoremap <M-8> :8b<CR>
nnoremap <M-9> :9b<CR>
nnoremap <M-0> :10b<CR>
" Switch windows using ctrl+hjkl
inoremap <C-W> <C-O><C-W>
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

"---------------------------------------------------------------------------}}}
" External Plugin Settings {{{
source ~/dotfiles/vim/plugin-settings/airline.vim
source ~/dotfiles/vim/plugin-settings/unite.vim
source ~/dotfiles/vim/plugin-settings/indent-guides.vim
source ~/dotfiles/vim/plugin-settings/vim-latex.vim
source ~/dotfiles/vim/plugin-settings/syntastic.vim
source ~/dotfiles/vim/plugin-settings/echodoc.vim
if g:is_exuberant
    source ~/dotfiles/.vim/plugin-settings/easytags.vim
endif
" Autocompleter
if s:autocompleter == 'old'
    source ~/.vim/plugin-settings/neocomplcache.vim
    source ~/.vim/plugin-settings/neosnippet.vim
elseif s:autocompleter == 'neo'
    source ~/.vim/plugin-settings/neocomplete.vim
    "source ~/.vim/plugin-settings/vim-marching.vim
    source ~/.vim/plugin-settings/jedi-vim.vim
    source ~/.vim/plugin-settings/lua-ftplugin.vim
    source ~/.vim/plugin-settings/ultisnips.vim
    let g:echodoc_enable_at_startup = 1
elseif s:autocompleter == 'ycm'
    source ~/.vim/plugin-settings/ycm.vim
    source ~/.vim/plugin-settings/ultisnips.vim
endif
"---------------------------------------------------------------------------}}}
" GVim Settings {{{
set guioptions-=L
set guioptions-=r
set guioptions+=c
"---------------------------------------------------------------------------}}}
"Local Machine Settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
