local win_id = vim.api.nvim_get_current_win()
vim.api.nvim_win_set_option(win_id, "listchars", "trail: ")

-- local winhl  = vim.api.nvim_win_get_option(win_id, "winhighlight")
-- vim.api.nvim_win_set_option(win_id, "winhighlight", winhl .. "Normal:NeogitNormal")
