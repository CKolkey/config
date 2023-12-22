return {
  "gbprod/substitute.nvim",
  keys = {
    {
      "s",
      [[<cmd>lua require("substitute").operator({ modifiers = { 'reindent' } })<cr>]],
      desc = "Substitute pending",
    },
    {
      "S",
      [[<cmd>lua require("substitute").eol()<cr>]],
      desc = "Substitute EOL",
    },
    {
      "ss",
      [[<cmd>lua require("substitute").line({ modifiers = { 'reindent' } })<cr>]],
      desc = "Substitute line",
    },
  },
  opts = {
    highlight_substituted_text = {
      enabled = true,
      timer = 500,
    },
  }
}
