local parser = vim.treesitter.language.get_lang("gitrebase")
if parser then
  vim.treesitter.start(0, parser)
  vim.cmd([[au BufUnload <buffer> lua vim.treesitter.stop(0)]])
end
