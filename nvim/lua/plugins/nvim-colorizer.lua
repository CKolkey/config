return {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = { "*", "!lazy" },
    buftype = { "*", "!prompt", "!nofile" },
  }
}
