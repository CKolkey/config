if _G.StatusColumn then
  return
end

_G.StatusColumn = {}

StatusColumn.set_window = function(value, defer, win)
  vim.defer_fn(function()
    win = win or vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_option(win, "statuscolumn", value)
  end, defer or 1)
end
