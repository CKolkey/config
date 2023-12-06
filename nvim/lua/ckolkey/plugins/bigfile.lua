return {
  "LunarVim/bigfile.nvim",
  opts = {
    filesize = 2, -- size of the file in Mb
    pattern = { "*" }, -- autocmd pattern
    features = {
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
      "vimopts",
      "filetype",
    },
  },
}
