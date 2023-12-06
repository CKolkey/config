vim.filetype.add({
  extension = {
  },
  filename = {
    ['.envrc'] = 'bash',
    ['Brewfile'] = 'brewfile',
  },
  pattern = {
    ['.*ignore$'] = "gitignore"
  }
})
