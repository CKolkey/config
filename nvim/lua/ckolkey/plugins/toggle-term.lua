local rspec_line = function()
  local cmd = "bundle exec rspec "
    .. vim.fn.expand("%:.")
    .. ":"
    .. vim.fn.line(".")
    .. " --format failures --out tmp/quickfix.out --format Fuubar"

  require("toggleterm").exec_command("cmd='" .. cmd .. "'")
end

local rspec_file = function()
  local cmd = "bundle exec rspec "
    .. vim.fn.expand("%:.")
    .. " --format failures --out tmp/quickfix.out --format Fuubar"

  require("toggleterm").exec_command("cmd='" .. cmd .. "'")
end

return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>tm", rspec_line, desc = "Run rspec for current line" },
    { "<leader>tM", rspec_file, desc = "Run rspec for current file" },
    { "<leader>ts", "<cmd>ToggleTermSendVisualSelection<cr>", desc = "Send selection to terminal" },
    { "<leader>tl", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Send line to terminal" },
  },
  opts = {
    open_mapping = [[``]],
    direction = "vertical",
    -- persist_mode    = false,
    shade_terminals = false,
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.4
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    on_create = function(term)
      StatusColumn.set_window("", 1, term.window)
      vim.api.nvim_win_set_option(term.window, "wrap", true)
      vim.api.nvim_win_set_option(term.window, "spell", false)
    end,
    highlights = {
      Normal = {
        guibg = Colors.bg0,
      },
    },
  },
}
