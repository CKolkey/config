return {
  "j-hui/fidget.nvim",
  -- init = function()
  -- vim.notify = require("fidget.notification").notify
  -- end,
  opts = {
    notification = {
      view = {
        stack_upwards = false,
      },
      window = {
        align_bottom = false
      }
    }
  },
}
