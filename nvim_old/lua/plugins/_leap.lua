local M = {}

M.config = function()
  require("leap").setup({})
end

M.omni = function()
  require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
end

return M
