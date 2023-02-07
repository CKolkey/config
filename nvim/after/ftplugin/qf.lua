vim.cmd([[
  execute('resize ' . min([10, len(getqflist())]))
]])
