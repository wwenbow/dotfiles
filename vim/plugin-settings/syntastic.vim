let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['yaml', 'json', 'lua', 'html', 'js', 'py'],
                           \ 'passive_filetypes': ['java'] }
" let g:syntastic_check_on_open = 1
let g:syntastic_lua_checkers = ["luac", "luacheck"]
let g:syntastic_lua_luacheck_args = "--no-unused-args"
let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_scala_checkers = ["ensime"]
