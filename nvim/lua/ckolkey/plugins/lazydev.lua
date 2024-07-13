return {
  {
    "folke/lazydev.nvim",
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true }, -- `vim.uv` typings
    },
    ft = "lua",
    opts = {
      library = {
        "luvit-meta/library",
      },
    },
  },
}
