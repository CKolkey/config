local M = {}

local dap = require("dap")

local window_hint = [[

]]

M.hydra = require("hydra")({
  name = "DAP",
  hint = window_hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      border = "rounded",
    },
    mode = { "n" },
    body = "<leader>db",
    heads = {
      { "c", dap.continue, { silent = true, desc = "Continue" } },
      { "n", dap.step_over, { silent = true, desc = "Step Over" } },
      { "s", dap.step_into, { silent = true, desc = "Step Into" } },
      { "o", dap.step_out, { silent = true, desc = "Step Out" } },
      { "b", dap.toggle_breakpoint, { silent = true, desc = "Toggle Breakpoint" } },
      {
        "B",
        function()
          dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        { desc = "Set Conditional Breakpoint" },
      },
      {
        "l",
        function()
          dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        { desc = "Set Log Breakpoint" },
      },
      { "R", dap.repl.open, { silent = true, desc = "REPL" } },
      { "r", dap.run_last, { silent = true, desc = "Run Last" } },
    },
  },
})

return M
