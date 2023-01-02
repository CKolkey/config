local colors = require("config.ui").colors
local icons = require("config.ui").icons

local diagnostics = function(_count, level)
  local icon = level:match("error") and icons.error or icons.warning
  return " " .. icon
end

return {
  "akinsho/bufferline.nvim",
  event = "BufAdd",
  config = function()
    require("bufferline").setup({
      options = {
        numbers = function(opts)
          local success, index = pcall(require("harpoon.mark").get_index_of, vim.api.nvim_buf_get_name(opts.id))
          if success and index and index > 0 then
            return opts.raise(index)
          else
            return ""
          end
        end,

        separator_style = "thick",

        themable = false,

        diagnostics = nil,

        close_command = require("mini.bufremove").delete,

        diagnostics_indicator = diagnostics,

        name_formatter = function(buffer)
          return " " .. buffer.name
        end,
      },

      highlights = {
        -- background color of bar (empty)
        fill = { bg = colors.black, fg = colors.none },

        -- hidden tabs
        background = { fg = colors.grey_dim, bg = colors.bg0 },

        -- close button in top right of window
        tab_close = { fg = colors.black, bg = colors.black },

        -- hidden tab close button
        close_button = { fg = colors.grey_light, bg = colors.bg0 },

        -- unfocused but visible tab
        close_button_visible = { fg = colors.grey_light, bg = colors.bg1 },

        -- Visible but unfocused
        buffer_visible = { fg = colors.inactive, bg = colors.bg1 },

        -- Active Tab close button
        close_button_selected = { fg = colors.fg, bg = colors.none },

        -- Active Buffer
        buffer_selected = { fg = colors.active, bg = colors.none, bold = true },

        -- Modified hidden buffer
        modified = { fg = colors.red, bg = colors.bg0 },

        -- Inactive buffer that is unsaved
        modified_visible = { fg = colors.red, bg = colors.bg1 },

        -- Active Buffer with modifications
        modified_selected = { fg = colors.red, bg = colors.none, bold = true, italic = true },

        -- space between, hidden buffer
        separator = { fg = colors.black, bg = colors.bg0 },

        -- Space Between, focused buffer
        separator_selected = { fg = colors.black, bg = colors.none },

        -- Space between, unfocused buffer
        separator_visible = { fg = colors.black, bg = colors.bg1 },

        -- left edge of active tab
        indicator_selected = { fg = colors.blue, bg = colors.none },

        -- Unfocused buffer number
        numbers = { fg = colors.fg, bg = colors.bg0 },
      },
    })
  end
}
