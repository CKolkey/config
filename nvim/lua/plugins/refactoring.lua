return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" }
  },
  keys = {
    { "<leader>rr", nil, desc = "Prompt to select refactor", mode = "v" }
  },
  config = function()
    vim.api.nvim_set_keymap(
      "v",
      "<leader>rr",
      ":lua require('refactoring').select_refactor()<CR>",
      { noremap = true, silent = true, expr = false }
    )
  end
}
