return {
  "NvChad/nvim-colorizer.lua",
  opts = {
    user_default_options = {
      names = false,
    },
    filetypes = {
      "*",
      "!lazy",
      "!TelescopePrompt",
      "!TelescopeResults",
      "!TelescopePreview",
    },
    buftypes = {
      "*",
      "!prompt",
      "!nofile",
      "!popup",
    },
  }
}
