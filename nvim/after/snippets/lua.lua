local M = {}

M.snippets = {
  plug = {
    description = "Plugin config file template",
    "local M = {}",
    newline(),
    newline("M.config = function()"),
    indent(),
    i(0),
    newline("end"),
    newline(),
    newline("return M"),
  },
}

return M
