return {
  "ckolkey/ts-node-action",
  dependencies = { "nvim-treesitter" },
  keys = {
    {
      "K",
      function()
        require("ts-node-action").node_action()
      end,
      desc = "Treesitter Node Action",
    },
  },
  opts = {},
  dev = true,
}
