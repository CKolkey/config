local M = {}

function M.format()
  if not vim.opt.modifiable:get() then return end

  local view = vim.fn.winsaveview()
  vim.cmd([[silent! keeppatterns keepjumps %s/\s\+$//e]]) -- Strip Trailing Whitespace
  vim.cmd([[silent! keeppatterns keepjumps %s#\($\n\s*\)\+\%$##]]) -- Strip Empty lines at EOF
  vim.fn.winrestview(view)
  vim.cmd([[undojoin | silent! update]])
end

return M
