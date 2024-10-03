return {
  "b0o/incline.nvim",
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    local c = require("ckolkey.config.ui.colors")

    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end

        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        return {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          guibg = c.bg2,
          guifg = props.focused and c.fg or c.grey_light,
        }
      end,
    })
  end,
  event = "VeryLazy",
}
