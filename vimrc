" Fold vimrc
set fdm=marker

" Plugin Settings {{{
if &compatible
  set nocompatible               " Be iMproved
endif

let vimplugInstalled=0
let plugvim=expand('~/dotfiles/vim/autoload/plug.vim')

if !filereadable(plugvim)
    echo "Installing vim-plug.."
    echo ""
    silent !curl -fLo ~/dotfiles/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vimplugInstalled=1
endif

set rtp+=~/.fzf

call plug#begin('~/dotfiles/vim/plugged')

"--------------------------------------------------------------------------}}}
" Bundles {{{

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

" My bundles here:
" original repos on GitHub
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'mbbill/undotree'
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-surround' "manipulate parenthesis
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
Plug 'mhinz/vim-grepper'
Plug 'airblade/vim-gitgutter'
Plug 'guns/vim-clojure-static'
Plug 'chase/vim-ansible-yaml'
Plug 'tomtom/tcomment_vim'
Plug 'embear/vim-localvimrc'
Plug 'iamcco/markdown-preview.vim'

" Web dev
" npm install tern in bundles/tern
" npm install -g jshint
if g:web_dev_plugins == 1
    Plug 'mattn/emmet-vim'
    Plug 'tmhedberg/matchit'
    Plug 'Valloric/MatchTagAlways'
    Plug 'pangloss/vim-javascript'
    Plug 'othree/javascript-libraries-syntax.vim'
    Plug 'ternjs/tern_for_vim', { 'do' : 'npm install' }
    Plug 'moll/vim-node'
    Plug 'briancollins/vim-jst'
endif


if v:version >= 703
    Plug 'Lokaltog/vim-easymotion'
endif

if g:is_exuberant
    Plug 'xolox/vim-easytags'
endif

" autocompleters
if s:autocompleter == 'old'
    Plug 'Shougo/neocomplcache.vim'
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
elseif s:autocompleter == 'neo'
    Plug 'Shougo/neocomplete.vim'
    "Plug 'Shougo/neosnippet.vim'
    "Plug 'Shougo/neosnippet-snippets'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'Shougo/echodoc'
    Plug 'davidhalter/jedi-vim'
    Plug 'derekwyatt/vim-scala'
    Plug 'vim-ruby/vim-ruby'
    "Plug 'ensime/ensime-vim'
    "Plug 'osyo-manga/vim-reunions'
    "Plug 'osyo-manga/vim-marching'
elseif s:autocompleter == 'ycm'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
endif

call plug#end()

filetype plugin indent on     " required!

if vimplugInstalled == 1
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    PlugInstall
endif

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
if has('unix')
    if has('macunix')
        set clipboard=unnamed
    else
        set clipboard=unnamedplus
    endif
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
"set relativenumber "makes some files slow
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=50
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
" Fast resize
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

"---------------------------------------------------------------------------}}}
" External Plugin Settings {{{
source ~/dotfiles/vim/plugin-settings/airline.vim
source ~/dotfiles/vim/plugin-settings/unite.vim
source ~/dotfiles/vim/plugin-settings/indent-guides.vim
source ~/dotfiles/vim/plugin-settings/vim-latex.vim
source ~/dotfiles/vim/plugin-settings/syntastic.vim
source ~/dotfiles/vim/plugin-settings/vim-localvimrc.vim
source ~/dotfiles/vim/plugin-settings/fzf.vim
source ~/dotfiles/vim/plugin-settings/markdown-preview.vim
if g:is_exuberant
    source ~/dotfiles/.vim/plugin-settings/easytags.vim
endif
" Autocompleter
if s:autocompleter == 'old'
    source ~/.vim/plugin-settings/neocomplcache.vim
    source ~/.vim/plugin-settings/neosnippet.vim
elseif s:autocompleter == 'neo'
    source ~/.vim/plugin-settings/neocomplete.vim
    source ~/.vim/plugin-settings/jedi-vim.vim
    source ~/.vim/plugin-settings/lua-ftplugin.vim
    source ~/.vim/plugin-settings/ultisnips.vim
    source ~/dotfiles/vim/plugin-settings/echodoc.vim
    "source ~/.vim/plugin-settings/vim-marching.vim
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
