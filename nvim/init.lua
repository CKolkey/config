require("utils")
require("config.options")
require("config.filetypes")
require("config.plugins")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.keymaps")
    require("config.autocmds")
    require("config.diagnostics")
  end,
})
