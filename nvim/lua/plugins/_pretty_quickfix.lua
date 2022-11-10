local M = {}

M.config = function()
  local icons = require("colors").icons

  require("pqf").setup({
    signs = {
      error = icons.error,
      warning = icons.warning,
      info = icons.info,
      hint = icons.hint,
    },
  })
end

return M
