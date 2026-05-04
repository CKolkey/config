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


lua << EOF
    vim.pack.add({"https://github.com/m00qek/baleia.nvim"})
    vim.g.baleia = require("baleia").setup({
        colors = {
            [0] = "#181a1b",
            [1] = "#e06c75",
            [2] = "#c3e88d",
            [3] = "#ffe082",
            [4] = "#82aaff",
            [5] = "#c792ea",
            [6] = "#6ce0cf",
            [7] = "#c5cdd9",
            [8] = "#5c6061",
            [9] = "#b5585f",
            [10] = "#9fbd73",
            [11] = "#d4a959",
            [12] = "#6c8ed4",
            [13] = "#a377bf",
            [14] = "#58b5a8",
            [15] = "#fcfcfc",
        }
    })
EOF

hi Normal guibg=#1c2026 guifg=#c5cdd9

augroup highlight_buffer
    autocmd!
    autocmd BufEnter * lua vim.g.baleia.once(vim.api.nvim_get_current_buf())
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require('vim.highlight').on_yank({timeout = 300})
    autocmd TextYankPost * lua vim.schedule(function() vim.cmd.sleep("300m"); vim.cmd.quit() end)
augroup END

augroup start_at_bottom
    autocmd!
    autocmd VimEnter * normal! G
    autocmd VimEnter * lua vim.api.nvim_feedkeys("1" .. vim.api.nvim_replace_termcodes("<c-u>", true, false, true), "n", false)
    autocmd VimEnter * lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<c-e>", true, false, true), "n", false)
augroup END

augroup prevent_insert
    autocmd!
    autocmd TermEnter * stopinsert
augroup END
