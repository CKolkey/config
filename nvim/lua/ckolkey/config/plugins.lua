-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("ckolkey.plugins", {
  rocks = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logiPat",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "rrhelper",
        "tar",
        "tarPlugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      }
    }
  },
  dev = {
    path = "~/code/",
    patterns = { "ckolkey" },
    fallback = true,
  },
  install = {
    colorscheme = { "onedark", "habamax" },
  },
  -- profiling = {
  --   loader = true,
  --   require = true,
  -- },
})

-- Async check for updates on launch
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local Checker = require("lazy.manage.checker")
    local a = require("plenary.async")

    a.void(Checker.fast_check)()
  end,
})
