return {
  "emmanueltouzery/agitator.nvim",
  keys = {
    {
      "<leader>gb",
      function()
        require("agitator").git_blame_toggle({
          formatter = function(r)
            local year = r.date.year > 2000 and r.date.year - 2000 or r.date.year
            return string.format("%02d.%02d.%02d %s", r.date.day, r.date.month, year, r.author)
          end,
        })
      end,
      desc = "Blame",
    },
    {
      "<leader>gc",
      function()
        local commit_sha = require("agitator").git_blame_commit_for_line()
        vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
      end,
      desc = "Blame Commit",
    },
  },
}
