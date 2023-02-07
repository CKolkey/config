return {
  "jose-elias-alvarez/null-ls.nvim",
  enabled = false,
  opts = {},
  config = function()
    require("null-ls").register({
      name = "more_actions",
      method = { require("null-ls").methods.CODE_ACTION },
      filetypes = { "_all" },
      generator = {
        fn = require("ts-node-action").available_actions
      }
    })
  end
}
