local M = {}

M.config = function()

  local c = require("colors")

  require("onedarkpro").setup({
    log_level = "debug",
    colors = c.colors,         -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
    highlights = c.highlights, -- Override default highlight and/or filetype groups
    filetypes = {
      ruby = false,
    },
    options = {
      bold = true,                            -- Use the colorscheme's opinionated bold styles?
      italic = true,                          -- Use the colorscheme's opinionated italic styles?
      underline = false,                       -- Use the colorscheme's opinionated underline styles?
      undercurl = false,                       -- Use the colorscheme's opinionated undercurl styles?
      cursorline = false,                      -- Use cursorline highlighting?
      transparency = true,                     -- Use a transparent background?
      terminal_colors = true,                  -- Use the colorscheme's colors for Neovim's :terminal?
      window_unfocused_color = true,           -- When the window is out of focus, change the normal background?
    }
  })

  vim.cmd("colorscheme onedarkpro")
end

return M
