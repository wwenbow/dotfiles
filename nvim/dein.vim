" Fold vimrc
set fdm=marker

" Plugin Settings {{{
if &compatible
  set nocompatible               " Be iMproved
endif

let vimplugInstalled=0
let plugvim=expand('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim/doc/dein.txt')

if !filereadable(plugvim)
    echo "Installing dein.."
    echo ""
    silent !curl -fLo ~/.config/nvim/dein/installer.sh --create-dirs https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
    silent !sh ~/.config/nvim/dein/installer.sh ~/.config/nvim/dein
    let vimplugInstalled=1
endif


" Required:
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.config/nvim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')


"--------------------------------------------------------------------------}}}
" Plugins {{{

let g:is_exuberant = 0

" Language plugins
let g:web_dev_plugins = 1

" Overrides
if filereadable(expand('~/nvimrc.local'))
    source ~/.nvimrc.local
endif

" My bundles here:
" original repos on GitHub
call dein#add('tpope/vim-fugitive')
call dein#add('scrooloose/nerdtree')
call dein#add('majutsushi/tagbar')
call dein#add('scrooloose/syntastic')
call dein#add('simnalamburt/vim-mundo')
call dein#add('altercation/vim-colors-solarized')
call dein#add('sickill/vim-monokai')
call dein#add('bling/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('kris89/vim-multiple-cursors')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('godlygeek/tabular') "easily make tables
call dein#add('tpope/vim-surround') "manipulate parenthesis
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neoyank.vim')
call dein#add('xolox/vim-misc')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('kien/rainbow_parentheses.vim')
call dein#add('tomtom/tcomment_vim')
call dein#add('Lokaltog/vim-easymotion')

call dein#add('Shougo/deoplete.nvim')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('davidhalter/jedi-vim')
call dein#add('xolox/vim-lua-ftplugin')
call dein#add('guns/vim-clojure-static')
call dein#add('chase/vim-ansible-yaml')
call dein#add('Shougo/echodoc')

" Web dev
" npm install tern in bundles/tern
" npm install -g jshint
if g:web_dev_plugins == 1
    call dein#add('mattn/emmet-vim')
    call dein#add('tmhedberg/matchit')
    call dein#add('Valloric/MatchTagAlways')
    call dein#add('pangloss/vim-javascript')
    call dein#add('othree/javascript-libraries-syntax.vim')
    call dein#add('ternjs/tern_for_vim', { 'build' : 'npm install'})
    call dein#add('carlitux/deoplete-ternjs')
    call dein#add('moll/vim-node')
    call dein#add('briancollins/vim-jst')
endif

if g:is_exuberant
    call dein#add('xolox/vim-easytags')
endif

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
  call dein#remote_plugins()
endif

"End dein Scripts-------------------------

"---------------------------------------------------------------------------}}}
" Colorscheme and Fonts {{{
set background=dark
colorscheme solarized
set t_Co=256

"---------------------------------------------------------------------------}}}
" Features {{{
"
syntax on "Enable syntax highlighting

" Copy ubuntu clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

set colorcolumn=80 "Highlight column 80, page border

"set tw=79 " Wrap text at column 79
"set nowrap

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
set notimeout ttimeout ttimeoutlen=200
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
" Natural slpit opening
set splitbelow
set splitright
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
nnoremap <F3> :nohl<CR>
" Gundo toggle
nnoremap <F5> :GundoToggle<CR>
" Tagbar toggle
nmap <F8> :TagbarToggle<CR>
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
noremap <C-Down>     <C-W>j
noremap <C-Up>       <C-W>k
noremap <C-Left>     <C-W>h
noremap <C-Right>    <C-W>l
"---------------------------------------------------------------------------}}}
" External Plugin Settings {{{
if g:is_exuberant
    source ~/dotfiles/.vim/plugin_settings/easytags.vim
endif
source ~/.vim/plugin_settings/ultisnips.vim
source ~/.config/nvim/plugin-settings/deoplete.vim
source ~/.config/nvim/plugin-settings/jed-vim.vim
source ~/.config/nvim/plugin-settings/lua-ftplugin.vim
source ~/.config/nvim/plugin-settings/deoplete-ternjs.vim
source ~/.config/nvim/plugin-settings/unite.vim
source ~/.config/nvim/plugin-settings/airline.vim
source ~/.config/nvim/plugin-settings/syntastic.vim
source ~/.config/nvim/plugin-settings/indent-guides.vim
source ~/.config/nvim/plugin-settings/echodoc.vim
"---------------------------------------------------------------------------}}}
"Local Machine Settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
