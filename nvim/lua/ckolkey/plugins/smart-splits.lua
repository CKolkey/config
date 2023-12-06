return {
  "mrjones2014/smart-splits.nvim",
  keys = {
    {
      "<m-left>",
      function()
        require("smart-splits").resize_left()
      end,
      desc = "Resize split left",
    },
    {
      "<m-up>",
      function()
        require("smart-splits").resize_up()
      end,
      desc = "Resize split up",
    },
    {
      "<m-right>",
      function()
        require("smart-splits").resize_right()
      end,
      desc = "Resize split right",
    },
    {
      "<m-down>",
      function()
        require("smart-splits").resize_down()
      end,
      desc = "Resize split down",
    },
  },
}
