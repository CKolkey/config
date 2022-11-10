local loaded, impatient = pcall(require, "impatient")
if loaded then
  impatient.enable_profile()
end

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print("Bootstrapping! Sit tight...")
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

  vim.api.nvim_command("packadd packer.nvim")
  vim.api.nvim_create_autocmd("User", { pattern = "PackerComplete", command = "quitall", once = true })

  require("utils").load()
  require("functions").load()
  require("plugins")
  require("packer").sync()
else
  local modules = { "utils", "functions", "settings", "lsp", "diagnostic", "commands", "autocmds", "mappings" }
  for _, module in ipairs(modules) do
    local ok, result = pcall(require, module)
    if ok then
      pcall(result.load)
    else
      vim.api.nvim_err_writeln("Error requiring " .. module .. ": " .. result)
    end
  end

  pcall(require, "packer_compiled")
  pcall(require, "plugins")
end
