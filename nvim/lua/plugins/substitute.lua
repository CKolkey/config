return {
  "gbprod/substitute.nvim",
  config = {
    on_substitute = function(_)
      vim.cmd("normal ==")
    end
  }
}
