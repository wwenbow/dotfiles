" add local directory to lua path for omni completion
autocmd FileType lua let $LUA_PATH = xolox#misc#os#exec({'command': 'luajit -e "print(package.path)"'})['stdout'][0]
autocmd FileType lua let $LUA_PATH = $LUA_PATH . ';' . getcwd() . '/?.lua'
autocmd FileType lua setlocal omnifunc=xolox#lua#omnifunc

let g:lua_check_syntax = 0
let g:lua_complete_omni = 1
let g:lua_complete_dynamic = 0

let g:neocomplete#force_omni_input_patterns.lua =
            \ '\w\+[.:]\|require\s*(\?["'']\w*'
" let g:neocomplcache_force_omni_patterns.lua =
" \ '\w\+[.:]\|require\s*(\?["'']\w*'
