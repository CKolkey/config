return {
  "stevearc/qf_helper.nvim",
  ft = "qf",
  keys = {
    { "<up>", ":QFPrev<cr>", desc = "Quickfix Previous" },
    { "<down>", ":QFNext<cr>", desc = "Quickfix Next" },
    { "<right>", ":QFToggle!<cr>", desc = "Quickfix Toggle" },
  },
  opts = {
    prefer_loclist = true,
    sort_lsp_diagnostics = true,
    quickfix = {
      autoclose = false,
      default_bindings = false,
      default_options = true,
      max_height = 10,
      min_height = 1,
      track_location = "cursor",
    },
    loclist = {
      autoclose = true,
      default_bindings = false,
      default_options = true,
      max_height = 10,
      min_height = 1,
      track_location = "cursor",
    },
  },
}
