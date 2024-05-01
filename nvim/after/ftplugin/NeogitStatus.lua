-- vim.cmd([[au ExitPre <buffer> tabclose | quit]])

vim.opt_local.colorcolumn = ""
vim.keymap.set("n", "V", "V", { buffer = true, noremap = true })

if StatusColumn then
  StatusColumn.set_window("%s ")
end
