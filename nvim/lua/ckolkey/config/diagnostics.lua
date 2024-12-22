vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
      [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
      [vim.diagnostic.severity.WARN]  = "DiagnosticLineWarn",
      [vim.diagnostic.severity.INFO]  = "DiagnosticLineInfo",
      [vim.diagnostic.severity.HINT]  = "DiagnosticLineHint",
    }
  }
})
