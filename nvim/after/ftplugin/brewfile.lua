-- https://github.com/kassio/dotfiles/blob/main/config/xdg/nvim/after/ftplugin/brewfile.lua
local cmd = function(str)
  local cmd_str = vim.api.nvim_replace_termcodes(str, true, true, true)
  vim.cmd(cmd_str)
end

local brew_sort = function()
  local saved_view = vim.fn.winsaveview()

  cmd('normal! ggV/^brew<CR>k:sort<CR>')
  cmd('normal! gg/^brew<CR>V/^cask<CR>k:sort<CR>')
  -- cmd('normal! gg/^cask<CR>V/^mas<CR>k:sort<CR>')
  -- cmd('normal! gg/^mas<CR>VG:sort<CR>')
  cmd('normal! <c-l>')
  cmd('write!')

  vim.fn.winrestview(saved_view)
end

vim.api.nvim_buf_create_user_command(0, 'Sort', brew_sort, {})

require("utils.autocmds").load({
  sort_brewfile = {
    desc = "Shows DB columns as virtual text",
    {
      event = { 'BufWritePre', 'FileWritePre' },
      pattern = "brewfile",
      callback = brew_sort
    }
  }
})
