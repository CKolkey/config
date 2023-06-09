return {
  "ruifm/gitlinker.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  opts = {
    opts = {
      action_callback = function(link)
        -- vim.fn.system("open " .. link)
        print("Copied Link to Clipboard")
        require("gitlinker.actions").copy_to_clipboard(link)
      end,
      print_url = false,
    },
    mappings = "<leader>gl"
  }
}
