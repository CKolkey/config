local function safe_require(mod)
  local ok, r = pcall(require, mod)
  if not ok then
    vim.schedule(function()
      error(r)
    end)
  end
end

safe_require("ckolkey.extensions")
safe_require("ckolkey.utils")
safe_require("ckolkey.config.options")
safe_require("ckolkey.config.filetypes")
safe_require("ckolkey.config.plugins")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    safe_require("ckolkey.config.keymaps")
    safe_require("ckolkey.config.autocmds")
    safe_require("ckolkey.config.diagnostics")

    if os.getenv("PROFILE") then
      require("plenary.profile").start("profile.log", { flame = true })
      vim.api.nvim_create_autocmd("VimLeavePre", { callback = require("plenary.profile").stop })
    end
  end,
})

vim.api.nvim_create_user_command("ProfileStart", function()
  require("plenary.profile").start("profile.log", { flame = true })
  -- vim.api.nvim_create_autocmd("VimLeavePre", { callback = require("plenary.profile").stop })
end, {})

vim.api.nvim_create_user_command("ProfileStop", require("plenary.profile").stop, {})
