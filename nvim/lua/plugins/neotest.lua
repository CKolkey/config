return {
  "nvim-neotest/neotest",
  enabled = false,
  lazy = true,
  dependencies = {
    "olimorris/neotest-rspec",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec"),
      },
      status = {
        virtual_text = true,
        signs = false,
      },
      icons = {
        passed = " ",
        running = " ",
        running_animated = {
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
        },
        failed = " ",
        skipped = " ",
        unknown = " ",

        collapsed = " ",
        expanded = " ",

        child_indent = "  ",
        child_prefix = "  ",
        final_child_indent = "  ",
        final_child_prefix = "  ",
        non_collapsible = "  ",
      },
      summary = {
        mappings = {
          expand = { "<CR>", "l" },
          expand_all = "e",
          output = "o",
          short = "O",
          attach = "a",
          jumpto = "i",
          stop = "s",
          run = "r",
        },
      },
    })
  end,
}
