local sort = function(a, b)
  if a.bufnr == b.bufnr then
    if a.lnum == b.lnum then
      return 0
    elseif a.lnum < b.lnum then
      return -1
    else
      return 1
    end
  else
    if vim.fn.bufname(a.bufnr) < vim.fn.bufname(b.bufnr) then
      return -1
    else
      return 1
    end
  end
end

vim.api.nvim_create_user_command(
  "QFSort",
  function() vim.fn.setqflist(vim.fn.sort(vim.fn.getqflist(), sort)) end,
  {}
)
