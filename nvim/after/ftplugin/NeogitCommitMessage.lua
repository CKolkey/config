-- https://github.com/megalithic/dotfiles/blob/main/config/nvim/after/ftplugin/neogitcommitmessage.lua
-- https://github.com/arsham/shark/blob/master/after/ftplugin/gitcommit.lua
--

vim.wo.colorcolumn = "50,72"
vim.opt.colorcolumn = "50,72"
vim.opt_local.colorcolumn = "50,72"

vim.opt_local.cursorline = false
vim.opt_local.textwidth = 72
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.list = false
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

vim.cmd([[setlocal comments+=fb:*]])
vim.cmd([[setlocal comments+=fb:-]])
vim.cmd([[setlocal comments+=fb:+]])
vim.cmd([[setlocal comments+=b:>]])

vim.cmd([[setlocal formatoptions+=c]])
vim.cmd([[setlocal formatoptions+=q]])

vim.cmd([[setlocal spell]])

-- vim.cmd([[exec 'norm! gg']])

-- if vim.fn.prevnonblank(".") ~= vim.fn.line(".") then
--   vim.cmd([[startinsert]])
-- end

-- local parser = vim.treesitter.language.get_lang("gitcommit")
-- if parser then
--   vim.treesitter.start(0, parser)
--   vim.cmd([[au BufUnload <buffer> lua vim.treesitter.stop(0)]])
-- end

vim.bo.formatoptions = vim.bo.formatoptions .. "t"

-- vim.fn.matchaddpos("Error", { { 1, 50, 10000 } })
