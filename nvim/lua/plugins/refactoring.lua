return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" }
  },
  keys = {
    { "<leader>e", function()
      require('refactoring').select_refactor()
    end, desc = "Prompt to select refactor", mode = "v" }
  },
}
