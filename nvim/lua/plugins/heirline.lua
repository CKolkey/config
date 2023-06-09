return {
  "rebelot/heirline.nvim",
  enabled = true,
  config = function()
    require("heirline").setup({
      statusline = require("plugins.ui.statusline"),
      statuscolumn = require("plugins.ui.statuscolumn"),
      -- winbar     = {
      --   { provider = "       ▐ ", hl = { fg = Colors.line_blue, bg = Colors.bg0 } },
      --   FileIcon,
      --   FilePath,
      --   separator,
      --   condition = conditions.is_not_active,
      --   hl = { bg = Colors.bg3 }
      -- },
    })
  end
}
