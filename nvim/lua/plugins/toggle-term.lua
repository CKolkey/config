return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.4
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    open_mapping = [[``]],
    on_create = function(term)
      StatusColumn.set_window("", 1, term.window)
    end,
    direction = "vertical",
    shade_terminals = false,
    highlights = {
      Normal = {
        guibg = Colors.bg0
      }
    }
  }
}
