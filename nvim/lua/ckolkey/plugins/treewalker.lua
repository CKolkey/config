return {
  "aaronik/treewalker.nvim",
  lazy = false,
  opts = {
    highlight = true,         -- Whether to briefly highlight the node after jumping to it
    highlight_duration = 250, -- How long should above highlight last (in ms)
  },
  keys = {
    -- { "<m-h>",   "<cmd>Treewalker Left<cr>",      desc = "Treewalker Left" },
    { "<m-j>", "<cmd>Treewalker Down<cr><cmd>norm! zt<cr>", desc = "Treewalker Down" },
    { "<m-k>", "<cmd>Treewalker Up<cr><cmd>norm! zt<cr>",   desc = "Treewalker Up" },
    -- { "<m-l>", "<cmd>Treewalker Right<cr>", desc = "Treewalker Right" },
    -- { "<m-s-h>", "<cmd>Treewalker SwapLeft<cr>",  desc = "Treewalker Swap Left" },
    -- { "<m-s-j>", "<cmd>Treewalker SwapDown<cr>",  desc = "Treewalker Swap Down" },
    -- { "<m-s-k>", "<cmd>Treewalker SwapUp<cr>",    desc = "Treewalker Swap Up" },
    -- { "<m-s-l>", "<cmd>Treewalker SwapRight<cr>", desc = "Treewalker Swap Right" },
  }
}
