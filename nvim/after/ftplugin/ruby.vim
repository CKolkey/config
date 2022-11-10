nnoremap <buffer><leader>bb obinding.b<esc>:w<cr>^

setlocal colorcolumn=120
setlocal textwidth=120
" set nofoldenable

" convert old ruby hashes to new ones
function! ConvertHashes() abort
  s/:\(.\{-}\)\s\?=>/\1:/g
endfunction
