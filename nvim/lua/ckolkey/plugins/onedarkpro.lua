return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    colors     = Colors,
    highlights = require("ckolkey.config.ui.highlights"),
    filetypes  = {
      ruby = false,
    },
    styles     = {
      comments  = "italic",
      methods   = "bold",
      functions = "bold",
    },
    options    = {
      transparency               = false, -- Use a transparent background?
      terminal_colors            = true, -- Use the colorscheme's colors for Neovim's :terminal?
      highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
    }
  },
  config = function(_, opts)
    require("onedarkpro").setup(opts)
    vim.cmd.colorscheme("onedark")
  end
}
