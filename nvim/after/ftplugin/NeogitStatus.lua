vim.opt_local.colorcolumn = ""
vim.keymap.set("n", "V", "V", { buffer = true, noremap = true })

-- Have escape "close" the tab with gt so it is reusable
-- vim.keymap.set("n", "<esc>", "gt", { buffer = true, noremap = true })

if StatusColumn then
  StatusColumn.set_window("%s ")
end
