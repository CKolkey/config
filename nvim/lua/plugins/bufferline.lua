return {
  "akinsho/bufferline.nvim",
  enabled = true,
  dependencies = {
    { "roobert/bufferline-cycle-windowless.nvim", opts = { default_enabled = true } }
  },
  opts = {
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
      diagnostics = false,
      custom_filter = function(buf, _buf_nums)
        if vim.bo[buf].buflisted
            and not vim.bo[buf].mod
            and vim.api.nvim_buf_get_name(buf) == ""
            and vim.fn.bufwinnr(buf) < 0
        then
          return false
        else
          return true
        end
      end,
      close_command = function()
        require("mini.bufremove").delete()
      end,
      diagnostics_indicator = function(_, level)
        return " " .. Icons.diagnostics[string.upper(level)]
      end,
      name_formatter = function(buffer)
        return " " .. buffer.name
      end,
    },

    highlights = {
      -- background color of bar (empty)
      fill = { bg = Colors.black, fg = Colors.none },

      -- hidden tabs
      background = { fg = Colors.grey_dim, bg = Colors.bg0 },

      -- close button in top right of window
      tab_close = { fg = Colors.black, bg = Colors.black },

      -- hidden tab close button
      close_button = { fg = Colors.grey_light, bg = Colors.bg0 },

      -- unfocused but visible tab
      close_button_visible = { fg = Colors.grey_light, bg = Colors.bg1 },

      -- Visible but unfocused
      buffer_visible = { fg = Colors.inactive, bg = Colors.bg1 },

      -- Active Tab close button
      close_button_selected = { fg = Colors.fg, bg = Colors.none },

      -- Active Buffer
      buffer_selected = { fg = Colors.active, bg = Colors.none, bold = true },

      -- Modified hidden buffer
      modified = { fg = Colors.red, bg = Colors.bg0 },

      -- Inactive buffer that is unsaved
      modified_visible = { fg = Colors.red, bg = Colors.bg1 },

      -- Active Buffer with modifications
      modified_selected = { fg = Colors.red, bg = Colors.none, bold = true, italic = true },

      -- space between, hidden buffer
      separator = { fg = Colors.black, bg = Colors.bg0 },

      -- Space Between, focused buffer
      separator_selected = { fg = Colors.black, bg = Colors.none },

      -- Space between, unfocused buffer
      separator_visible = { fg = Colors.black, bg = Colors.bg1 },

      -- left edge of active tab
      indicator_selected = { fg = Colors.blue, bg = Colors.none },

      -- Unfocused buffer number
      numbers = { fg = Colors.fg, bg = Colors.bg0 },
    },
  }
}
