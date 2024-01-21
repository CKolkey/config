for _, level in ipairs({ "Error", "Warn", "Info", "Hint" }) do
  vim.fn.sign_define(
    "DiagnosticSign" .. level,
    { text = "", numhl = "Diagnostic" .. level, linehl = "DiagnosticLine" .. level }
  )
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  severity_sort = true,
})
