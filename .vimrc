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
	let neobundle_readme=expand('~/vimfiles/bundle/neobundle.vim/README.md')
else
	let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
endif

if !filereadable(neobundle_readme)
    echo "Installing neobundle.."
    echo ""
    if has('win32') || has('win64')
        silent !mkdir -p ~/vimfiles/bundle
        silent !git clone https://github.com/Shougo/neobundle.vim ~/vimfiles/bundle/neobundle.vim
    else
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    endif
    let iCanHazNeoBundle=0
endif

if has('win32') || has('win64')
	set runtimepath+=~/vimfiles/bundle/neobundle.vim/
	let path='~/vimfiles/bundle'
	call neobundle#rc(expand(path))
else
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	let path='~/.vim/bundle'
	call neobundle#rc(expand(path))
endif

" let NeoBundle manage NeoBundle
" required! 
NeoBundleFetch 'Shougo/neobundle.vim'

" My bundles here:
" original repos on GitHub
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }
NeoBundle 'Shougo/unite.vim'

" autocompleters
if v:version < 703
    NeoBundle 'Shougo/neocomplcache.vim'
    NeoBundle 'Shougo/neosnippet.vim'
    NeoBundle 'Shougo/neosnippet-snippets'
elseif has('win32') | has('win64')
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neosnippet.vim'
    NeoBundle 'Shougo/neosnippet-snippets'
else 
    NeoBundle 'Valloric/YouCompleteMe' , {
                \ 'build' : {
                \    'unix' : './install.sh --clang-completer'
                \    },
                \ }
    NeoBundle 'SirVer/ultisnips'
    NeoBundle 'honza/vim-snippets'
endif

" Sourceforge
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
"
" scripts from http://vim-scripts.org/vim/scripts.html

filetype plugin indent on     " required!

NeoBundleCheck

if iCanHazNeoBundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    NeoBundleInstall
endif
" Setting up NeoBundle - the vim plugin bundler end

"---------------------------------------------------------------------------}}}
" Colorscheme {{{
set background=dark
colorscheme solarized
set t_Co=256
" font
if has("gui_running")
    if has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    elseif has("gui_gtk2")
        set guifont=Ubuntu\ Mono\ derivative\ Powerline h11 
    endif
endif

"---------------------------------------------------------------------------}}}
" Features {{{
"
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" Copy ubuntu clipboard
if ("unix")
    set clipboard=unnamedplus
else 
    set clipboard=unnamed
endif

" Omni completion
set omnifunc=syntaxcomplete#Complete

" Highlight column 80, page border
if v:version >= 703
    set colorcolumn=80
endif

" Wrap text at column 79
" set tw=79

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
autocmd BufWritePre *.cu :%s/\s\+$//e

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
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
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
" cs267 2 tabs
autocmd BufRead */cs_267/homewor*/*.c* :set shiftwidth=2 softtabstop=2

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
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

"---------------------------------------------------------------------------}}}
" Vim-Latex Settings {{{
"
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_UseMakefile=0

"---------------------------------------------------------------------------}}}
" Airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_nr_show = 1

"---------------------------------------------------------------------------}}}
" Unite {{{
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>g :<C-u>Unite -no-split grep:.<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer -quick-match  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

"---------------------------------------------------------------------------}}}
" External Plugin Settings {{{
" Autocompleter 
if v:version < 703 
    source ~/.vim/plugin_settings/neocomplcache.vim
elseif has('win32') | has('win64')
    source ~/.vim/plugin_settings/neocomplete.vim
else
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
endif 
"---------------------------------------------------------------------------}}}
