return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon: Add file",
    },
    {
      "<leader>hh",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon: Quick menu",
    },
    {
      "<leader>h1",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Harpoon: Navigate 1",
    },
    {
      "<leader>h2",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Harpoon: Navigate 2",
    },
    {
      "<leader>h3",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Harpoon: Navigate 3",
    },
    {
      "<leader>h4",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Harpoon: Navigate 4",
    },
    {
      "<leader>h5",
      function()
        require("harpoon.ui").nav_file(5)
      end,
      desc = "Harpoon: Navigate 5",
    },
    {
      "<leader>h6",
      function()
        require("harpoon.ui").nav_file(6)
      end,
      desc = "Harpoon: Navigate 6",
    },
    {
      "<leader>h7",
      function()
        require("harpoon.ui").nav_file(7)
      end,
      desc = "Harpoon: Navigate 7",
    },
    {
      "<leader>h8",
      function()
        require("harpoon.ui").nav_file(8)
      end,
      desc = "Harpoon: Navigate 8",
    },
    {
      "<leader>h9",
      function()
        require("harpoon.ui").nav_file(9)
      end,
      desc = "Harpoon: Navigate 9",
    },
    {
      "<leader>h0",
      function()
        require("harpoon.ui").nav_file(10)
      end,
      desc = "Harpoon: Navigate 10",
    },
  },
}
