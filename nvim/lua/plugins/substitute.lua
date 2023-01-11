return {
  "gbprod/substitute.nvim",
  opts = {
    on_substitute = function(_)
      vim.cmd("normal ==")
    end
  }
}
