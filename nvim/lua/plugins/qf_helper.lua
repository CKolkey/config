return {
  "stevearc/qf_helper.nvim",
  ft = "quickfix",
  cmd = { "QPrev", "QNext", "QFToggle" },
  config = {
    prefer_loclist = true,
    sort_lsp_diagnostics = true,
    quickfix = {
      autoclose = false,
      default_bindings = false,
      default_options = true,
      max_height = 10,
      min_height = 1,
      track_location = 'cursor',
    },
    loclist = {
      autoclose = true,
      default_bindings = false,
      default_options = true,
      max_height = 10,
      min_height = 1,
      track_location = 'cursor',
    },
  }
}
