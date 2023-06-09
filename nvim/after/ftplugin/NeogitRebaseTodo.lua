-- local parser = vim.treesitter.language.get_lang("gitrebase")
-- if parser then
--   vim.treesitter.start(0, parser)
--   vim.cmd([[au BufUnload <buffer> lua vim.treesitter.stop(0)]])
-- end

vim.cmd([[
  execute "normal! gg/^# Rebase.*onto\<Enter>"
  execute "normal! wwyt."
  execute "normal! ggV}k:!git-rr " . getreg('"') . "\<Enter>"
  execute "normal! gg/^pick\<Enter>"
  execute "silent nohl"

  nnoremap <buffer> gj /\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)<CR>:nohl<CR>
  nnoremap <buffer> gk ?\v^(pick\|reword\|edit\|squash\|fixup\|exec\|drop)<CR>:nohl<CR>
  nnoremap <buffer> gf /FILE\s<CR>:nohl<CR>
  nnoremap <buffer> gF ?FILE\s<CR>:nohl<CR>
]])
