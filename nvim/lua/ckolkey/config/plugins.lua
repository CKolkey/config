-- Bootstrap
local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(install_path) then
  local repo = "git@github.com:folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", install_path })
end

vim.opt.rtp:prepend(install_path)

require("lazy").setup("ckolkey.plugins", {
  rocks = {
    enabled = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
  dev = {
    path = "~/code/",
    patterns = { "ckolkey" },
    fallback = true,
  },
  checker = {
    enabled = true,
  },
  install = {
    colorscheme = { "onedark", "habamax" },
  },
  profiling = {
    loader = true,
    require = true,
  },
})
