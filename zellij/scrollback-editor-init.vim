set norelativenumber
set nonumber
set noswapfile
set mouse=a
set clipboard+=unnamedplus
set virtualedit=all
set scrollback=100000
set termguicolors
set laststatus=0
set background=dark
set ignorecase
set scrolloff=0
set cmdheight=0

noremap q :qa!<CR>
nnoremap <esc> :qa!<CR>

nnoremap <silent> vv V
nnoremap <silent> V v$
nnoremap <silent> H ^
nnoremap <silent> L g_
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> H ^
vnoremap <silent> L g_
vnoremap <silent> j gj
vnoremap <silent> k gk

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require('vim.highlight').on_yank({timeout = 300})
    autocmd TextYankPost * lua vim.schedule(function() vim.cmd.sleep("300m"); vim.cmd.quit() end)
augroup END

augroup start_at_bottom
    autocmd!
    autocmd VimEnter * normal! G
    autocmd VimEnter * lua vim.api.nvim_feedkeys("1" .. vim.api.nvim_replace_termcodes("<c-u>", true, false, true), "n", false)
augroup END

augroup prevent_insert
    autocmd!
    autocmd TermEnter * stopinsert
augroup END
