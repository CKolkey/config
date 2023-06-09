local win_id = vim.api.nvim_get_current_win()
local winhl  = vim.api.nvim_win_get_option(win_id, "winhighlight")
vim.api.nvim_win_set_option(win_id, "winhighlight", winhl .. "Normal:NeogitNormal,WinSeparator:NeogitWinSeparator,CursorLineNr:NeogitCursorLineNr")
vim.api.nvim_win_set_option(win_id, "spell", false)
vim.api.nvim_win_set_option(win_id, "colorcolumn", "")
vim.api.nvim_win_set_option(win_id, "list", false)

vim.cmd([[au ExitPre <buffer> tabclose | quit]])

StatusColumn.set_window(" %s ")
