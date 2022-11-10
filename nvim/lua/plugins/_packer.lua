local M = {}

M.config = {
  compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  profile = { enable = true, threshold = 1 },
  auto_clean = true,
  compile_on_sync = true,
  git = {
    clone_timeout = 300,
    subcommands = {
      fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
    },
  },
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
}

return M
