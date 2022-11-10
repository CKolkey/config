local M = {}

M.config = function()
  require("neotest").setup({
    adapters = {
      require("neotest-rspec"),
    },
    status = {
      virtual_text = true,
      signs = false,
    },
    icons = {
      passed = " ",
      running = " ",
      -- running_animated = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
      running_animated = {
        "", "", "", "", "", "", "",
        "", "", "", "", "", "", "",
        "", "", "", "", "", "", "",
        "", "", "", "", "", "", ""
      },
      failed = " ",
      skipped = " ",
      unknown = " ",
    },
    summary = {
      mappings = {
        expand = { "<CR>", "l" },
        expand_all = "e",
        output = "o",
        short = "O",
        attach = "a",
        jumpto = "i",
        stop = "s",
        run = "r",
      },
    },
  })
end

return M
