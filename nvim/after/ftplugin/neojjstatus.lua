vim.opt_local.colorcolumn = ""
vim.keymap.set("n", "V", "V", { buffer = true, noremap = true })

-- Have escape "close" the tab with gt so it is reusable
-- vim.keymap.set("n", "<esc>", "gt", { buffer = true, noremap = true })

vim.b.matchup_matchparen_enabled = 0
vim.b.matchup_matchparen_fallback = 0

if StatusColumn then
  StatusColumn.set_window("%s ")
end
