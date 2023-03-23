return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping    = [[``]],
    direction       = "vertical",
    -- persist_mode    = false,
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
      vim.api.nvim_win_set_option(term.window, "wrap", true)
      vim.api.nvim_win_set_option(term.window, "spell", false)
    end,
    highlights      = {
      Normal = {
        guibg = Colors.bg0
      }
    }
  }
}
