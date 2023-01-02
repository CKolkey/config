return {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  config = {
    filetypes = { "*", "!lazy" },
    buftype = { "*", "!prompt", "!nofile" },
  }
}
