vim.loader.enable()

require("extensions")
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

    if os.getenv("PROFILE") then
      require("plenary.profile").start("profile.log", { flame = true })
      vim.api.nvim_create_autocmd("VimLeavePre", { callback = require("plenary.profile").stop })
    end
  end,
})

vim.api.nvim_create_user_command("ProfileStart", function()
  require("plenary.profile").start("profile.log", { flame = true })
  vim.api.nvim_create_autocmd("VimLeavePre", { callback = require("plenary.profile").stop })
end, {})

vim.api.nvim_create_user_command("ProfileStop", require("plenary.profile").stop, {})
