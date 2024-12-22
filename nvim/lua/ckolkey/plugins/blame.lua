-- git blame
Colors = require("ckolkey.config.ui.colors")

return {
  "FabijanZulj/blame.nvim",
  lazy = true,
  cmd = "BlameToggle",
  keys = {
    { "<leader>gb", "<cmd>BlameToggle window<cr>", desc = "Blame" },
    {
      "<leader>gB",
      function()
        local current_file = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0))
        if current_file then
          local result = vim
              .system({ "git", "blame", "-L" .. vim.fn.line(".") .. "," .. vim.fn.line("."), current_file },
                { text = true })
              :wait()

          local commit_sha, _ = result.stdout:gsub("%s.*$", "")
          vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
        end
      end,
      desc = "Blame Commit",
    },
  },
  -- init = function()
  --   local BlameWindow = require("blame.views.window_view")
  --
  --   function BlameWindow:show_full_commit()
  --     local NeogitCommitView = require("neogit.buffers.commit_view")
  --
  --     local row, _ = unpack(vim.api.nvim_win_get_cursor(self.blame_window))
  --     local commit = self.blamed_lines[row]
  --     local view = NeogitCommitView.new(commit.hash)
  --
  --     view:open("floating")
  --     view.buffer:set_window_option("scrollbind", false)
  --     view.buffer:set_window_option("cursorbind", false)
  --   end
  -- end,
  opts = {
    commit_detail_view = function(sha, _row, _path)
      local NeogitCommitView = require("neogit.buffers.commit_view")
      local view = NeogitCommitView.new(sha)
      view:open("floating")

      view.buffer:set_window_option("scrollbind", false)
      view.buffer:set_window_option("cursorbind", false)
    end,
    merge_consecutive = true,
    colors = {
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.cyan,
      Colors.blue,
      Colors.purple,
    },
    mappings = {
      stack_push = "]]",
      stack_pop = "[[",
    },
  },
}
