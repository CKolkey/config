return {
  "gbprod/substitute.nvim",
  keys = {
    {
      "s",
      [[<cmd>lua require("substitute").operator()<cr>]],
      desc = "Substitute pending",
    },
    {
      "S",
      [[<cmd>lua require("substitute").eol()<cr>]],
      desc = "Substitute EOL",
    },
    {
      "ss",
      [[<cmd>lua require("substitute").line()<cr>]],
      desc = "Substitute line",
    },
  },
  opts = {
    on_substitute = function(_)
      vim.cmd("normal ==")
    end,
  },
}
