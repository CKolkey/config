return {
  "ckolkey/ts-node-action",
  dependencies = {
    "nvim-treesitter"
  },
  lazy = true,
  dev = true,
  dir = vim.fn.expand("~") .. "/code/ts-node-action/",
}
