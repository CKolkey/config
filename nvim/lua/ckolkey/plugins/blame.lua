-- git blame
Colors = require("ckolkey.config.ui.colors")

return {
  "FabijanZulj/blame.nvim",
  lazy = true,
  dev = true,
  cmd = "BlameToggle",
  keys = {
    { "<leader>gb", "<cmd>BlameToggle window<cr>", desc = "Blame" },
    -- {
    --   "<leader>gc",
    --   function()
    --     local commit_sha = require("agitator").git_blame_commit_for_line()
    --     vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
    --   end,
    --   desc = "Blame Commit",
    -- },
  },
  opts = {
    merge_consecutive = true,
    mappings = {
      colors = {
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.cyan,
        Colors.blue,
        Colors.purple,
      },
      stack_push = "]]",
      stack_pop  = "[[",
    }
  },
}
