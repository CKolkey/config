local M = {}

M.config = function()
  require("substitute").setup({
    on_substitute = function(_)
      vim.cmd("normal ==")
    end
  })
end

return M
