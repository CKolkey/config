vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Toggle the profiler
    Snacks.toggle.profiler():map("<leader>pp")
    -- Toggle the profiler highlights
    Snacks.toggle.profiler_highlights():map("<leader>ph")


    _G.dd = function(...)
      Snacks.debug.inspect(...)
    end

    _G.bt = function()
      Snacks.debug.backtrace()
    end

    vim.print = _G.dd

    Snacks.scroll.enable()
  end,
})

return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    bigfile = {},
    dim = {},
    quickfile = {},
    scroll = {},
  },
  keys = {
    { "<leader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Bufer" },
  }
}
