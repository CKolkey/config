return {
  "aaronik/treewalker.nvim",
  opts = {
    highlight = true,         -- Whether to briefly highlight the node after jumping to it
    highlight_duration = 250, -- How long should above highlight last (in ms)
  },
  keys = {
    { "<c-m-h>", "<cmd>Treewalker Left<cr>",              desc = "Treewalker Left" },
    { "<c-m-j>", "<cmd>Treewalker Down<cr>",              desc = "Treewalker Left" },
    { "<c-m-k>", "<cmd>Treewalker Up<cr>",              desc = "Treewalker Left" },
    { "<c-m-l>", "<cmd>Treewalker Right<cr>",              desc = "Treewalker Left" },
  }
}
