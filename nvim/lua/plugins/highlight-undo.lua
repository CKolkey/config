return {
  "tzachar/highlight-undo.nvim",
  change = {
    hlgroup = "HighlightUndo",
    duration = 1000,
    keymaps = {
      { "n", "u", "undo", {} },
      { "n", "<C-r>", "redo", {} },
    },
  },
}
