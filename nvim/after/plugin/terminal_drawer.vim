if exists("g:loaded_terminal_drawer")
  finish
endif
let g:loaded_terminal_drawer = 1

let g:terminal_drawer_height   = 0.40
let g:terminal_drawer_position = "botright"
let g:terminal_drawer          = { 'win_id': v:null, 'buffer_id': v:null, 'terminal_job_id': v:null, 'state': 'closed' }

function! ToggleTerminalDrawer() abort
  if win_gotoid(g:terminal_drawer.win_id)
    call CloseTerminalDrawer()
  else
    call OpenTerminalDrawer()
  endif
endfunction

function! CloseTerminalDrawer() abort
  if g:terminal_drawer.state == 'closed'
    return
  endif

  hide
  let g:terminal_drawer.state = 'closed'
  stopinsert
endfunction

function! SmartCloseTerminal() abort
  if win_gotoid(g:terminal_drawer.win_id)
    call CloseTerminalDrawer()
  endif
endfunction

function! OpenTerminalDrawer() abort
  if g:terminal_drawer.state == 'open'
    return
  endif

  exec g:terminal_drawer_position . float2nr(&lines * g:terminal_drawer_height) . "new"

  try
    exec 'buffer' g:terminal_drawer.buffer_id
  catch
    call termopen($SHELL, {"detach": 0})
    let g:terminal_drawer.buffer_id = bufnr("")
  endtry

  setlocal nobuflisted nowrap signcolumn=no scrolloff=0 filetype=terminal
  startinsert!

  let b:minicursorword_disable = v:true
  let g:terminal_drawer.win_id = win_getid()
  let g:terminal_drawer.terminal_job_id = b:terminal_job_id
  let g:terminal_drawer.state = 'open'

  tnoremap <buffer><Esc> <C-\><C-n>
  nnoremap <buffer><cr> i
endfunction
