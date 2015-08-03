" path to clang command
let g:marching_clang_command = "C:/LLVM/bin/clang.exe"

" directory paths to include
let g:marching_include_paths = [
            \	"C:/MinGW/lib/gcc/mingw32/4.6.2/include/c++"
            \]
let g:marching_clang_command_option="-std=c++1y"

" cooperate with neocomplete.vim
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'   

imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
