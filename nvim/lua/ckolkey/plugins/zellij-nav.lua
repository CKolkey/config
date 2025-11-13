return {
  "swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<C-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { desc = "navigate left or tab" } },
    { "<C-j>", "<cmd>ZellijNavigateDown<cr>",     { desc = "navigate down" } },
    { "<C-k>", "<cmd>ZellijNavigateUp<cr>",       { desc = "navigate up" } },
    { "<C-l>", "<cmd>ZellijNavigateRightTab<cr>", { desc = "navigate right or tab" } },
  },
  opts = {},
}
