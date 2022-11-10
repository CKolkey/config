local M = {}

function M.load()
  -- TERMINAL DRAWER {{{
  -- TODO: save buffer ID when entering, return to that ID when exiting
  vim.cmd([[
    let g:terminal_drawer_height   = 0.25
    let g:terminal_drawer_position = "botright"

    if !exists('g:terminal_drawer')
      let g:terminal_drawer = { 'win_id': v:null, 'buffer_id': v:null, 'terminal_job_id': v:null, 'state': 'closed' }
    endif

    function! ToggleTerminalDrawer() abort
      if win_gotoid(g:terminal_drawer.win_id)
        call CloseTerminalDrawer()
      else
        call OpenTerminalDrawer()
      endif
    endfunction

    function! CloseTerminalDrawer() abort
      " Don't closed terminal if already closed
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
      " Don't open terminal if already open
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

      call RemoveEmptyBuffers()

      setlocal nobuflisted
      setlocal listchars= nonumber norelativenumber nowrap winfixwidth noruler signcolumn=no noshowmode scrolloff=0
      startinsert!

      let b:minicursorword_disable = v:true
      let g:terminal_drawer.win_id = win_getid()
      let g:terminal_drawer.terminal_job_id = b:terminal_job_id
      let g:terminal_drawer.state = 'open'

      tnoremap <buffer><Esc> <C-\><C-n>
      nnoremap <buffer><cr> i
    endfunction
 ]])
  -- }}}
  -- REMOVE EMPTY BUFFERS {{{
  vim.cmd([[
    function! RemoveEmptyBuffers()
      let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
      if !empty(buffers)
        silent exe 'bw ' . join(buffers, ' ')
      endif
    endfunction
]])
  -- }}}
  -- REMOVE TRAILING WHITESPACE {{{
  vim.cmd([[
    function! TrimWhitespace()
      if &l:modifiable
        let l:save = winsaveview()
        try
          silent! keeppatterns keepjumps %s/\s\+$//e
        finally
          call winrestview(l:save)
        endtry
      endif
    endfunction
]])
  -- }}}
  -- REMOVE EMPTY LINES AT EOF {{{
  vim.cmd([[
    function! TrimEndLines()
      let save_cursor = getpos(".")
      silent! %s#\($\n\s*\)\+\%$##
      call setpos('.', save_cursor)
    endfunction
]])
  -- }}}
  vim.cmd([[
    function! SmartInsert()
      if len(getline('.')) == 0
        return "\"_cc"
      else
        return "i"
      endif
    endfunction
]])
  -- }}}
  -- EDIT VIM FT FILE {{{
  vim.cmd([[
    function! EditFtFile()
      return ':e ' . $HOME . '/.config/nvim/after/ftplugin/' . &filetype . '.vim'
    endfunction
]])
  -- }}}
  -- EcredentialsRails {{{
  vim.cmd([[
    function! EcredentialsRails() abort
      if g:terminal_drawer.terminal_job_id == v:null
        echom "No Terminal Available"
        return
      endif
      call jobsend(g:terminal_drawer.terminal_job_id, "rails credentials:edit\n")
    endfunction
  ]])
  -- }}}
  -- GitDiff {{{
  vim.cmd([[
    let s:git_status_dictionary = {
                \ "A": "Added",
                \ "B": "Broken",
                \ "C": "Copied",
                \ "D": "Deleted",
                \ "M": "Modified",
                \ "R": "Renamed",
                \ "T": "Changed",
                \ "U": "Unmerged",
                \ "X": "Unknown"
                \ }

    function! s:get_diff_files(rev)
      let list = map(split(system(
                  \ 'git diff --name-status '.a:rev), '\n'),
                  \ '{"filename":matchstr(v:val, "\\S\\+$"),"text":s:git_status_dictionary[matchstr(v:val, "^\\w")]}'
                  \ )
      call setqflist(list)
      copen
    endfunction
  ]])
  -- }}}
end

function M.format()
  if not vim.opt.modifiable:get() then return end

  local view = vim.fn.winsaveview()
  vim.cmd([[silent! keeppatterns keepjumps %s/\s\+$//e]])
  vim.cmd([[silent! keeppatterns keepjumps %s#\($\n\s*\)\+\%$##]])
  vim.fn.winrestview(view)
  vim.cmd([[undojoin | silent! update]])
end

-- Don't yank empty lines into the main register
function M.smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end

return M
