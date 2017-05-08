" let g:unite_source_history_yank_enable = 1
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#custom#profile('default', 'context', {
"             \   'start_insert': 1,
"             \   'winheight': 10,
"             \   'direction': 'botright',
"             \ })
" nnoremap <leader>f :<C-u>Denite -buffer-name=files -resume file_rec<cr>
" nnoremap <leader>g :<C-u>Denite grep<cr>
" nnoremap <leader>r :<C-u>Denite -buffer-name=mru file_mru<cr>
" nnoremap <leader>b :<C-u>Denite -buffer-name=buffer buffer<cr>
"
" " Custom mappings for the unite buffer
" autocmd FileType denite call s:unite_settings()
" function! s:unite_settings()
"   " Enable navigation with control-j and control-k in insert mode
"   imap <buffer> <C-j>   <Plug>(unite_select_next_line)
"   imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
"   imap <buffer> <C-r>   <Plug>(unite_redraw)
" endfunction
