return {
  "rebelot/heirline.nvim",
  enabled = true,
  config = function()
    require("heirline").setup({
      statusline = require("ckolkey.plugins.ui.statusline"),
      statuscolumn = require("ckolkey.plugins.ui.statuscolumn"),
    })
  end
}
