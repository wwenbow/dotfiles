autocmd FileType lua setlocal omnifunc=xolox#lua#omnifunc

let g:lua_check_syntax = 0
let g:lua_complete_omni = 1
let g:lua_complete_dynamic = 0
let g:lua_define_completion_mappings = 0
let g:lua_interpreter_path = 'luajit'

let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'
