return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping    = [[``]],
    direction       = "vertical",
    shade_terminals = false,
    size            = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.4
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    on_create       = function(term)
      StatusColumn.set_window("", 1, term.window)
    end,
    highlights      = {
      Normal = {
        guibg = Colors.bg0
      }
    }
  }
}
