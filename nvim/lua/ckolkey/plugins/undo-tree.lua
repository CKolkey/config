return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" }
  },
  init = function()
    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_SplitWidth = 50
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_DiffAutoOpen = 0
  end
}
