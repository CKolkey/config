return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
  },
  -- stylua: ignore
  keys = {
    { "<leader>dt", "<cmd>diffthis<CR>",                               mode = { "n" }, desc = "Diff this" },
    { "<leader>do", "<cmd>diffoff<CR>",                                mode = { "n" }, desc = "Diff off" },
    { "<leader>dd", "<cmd>DiffviewOpen<cr>",                           mode = { "n" }, desc = "Repo Diffview", nowait = true },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>",                    mode = { "n" }, desc = "Repo history" },
    { "<leader>df", "<cmd>DiffviewFileHistory --follow %<cr>",         mode = { "n" }, desc = "File history" },
    { "<leader>dm", "<cmd>DiffviewOpen master<cr>",                    mode = { "n" }, desc = "Diff with master" },
    { "<leader>dl", "<cmd>.DiffviewFileHistory --follow<CR>",          mode = { "n" }, desc = "Line history" },
    { "<leader>dd", "<esc><cmd>'<,'>DiffviewFileHistory --follow<CR>", mode = { "v" }, desc = "Range history" },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      icons = {
        folder_closed = Icons.misc.folder_closed,
        folder_open = Icons.misc.folder_open,
      },
      signs = {
        fold_closed = Icons.misc.collapsed,
        fold_open = Icons.misc.expanded,
        done = Icons.git.staged,
      },
      file_panel = {
        listing_style = "list",
        win_config = {
          position = "top",
          height = 10,
        },
      },
      keymaps = {
        view = {
          { "n", "q", ":DiffviewClose<cr>", { desc = "Close Panel" } },
          { "n", "<esc>", ":DiffviewClose<cr>", { desc = "Close Panel" } },
          { "n", "<c-n>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<c-p>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<c-c>", actions.toggle_files, { desc = "Toggle the file panel" } },
        },
        file_history_panel = {
          { "n", "q", ":DiffviewClose<cr>", { desc = "Close Panel" } },
          { "n", "<esc>", ":DiffviewClose<cr>", { desc = "Close Panel" } },
          { "n", "<c-n>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<c-p>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<cr>", actions.goto_file, { desc = "Open the file in a new split in the previous tabpage" } },
          { "n", "<c-c>", actions.toggle_files, { desc = "Toggle the file panel" } },
        },
        file_panel = {
          { "n", "q", ":DiffviewClose<cr>", { desc = "Close Panel" } },
          { "n", "<esc>", ":DiffviewClose<cr>", { desc = "Close Panel" } },
          { "n", "<c-n>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<c-p>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "X", actions.restore_entry, { desc = "Restore entry to the state on the left side." } },
          { "n", "<cr>", actions.goto_file, { desc = "Open the file in a new split in the previous tabpage" } },
          { "n", "i", actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
          { "n", "R", actions.refresh_files, { desc = "Update stats and entries in the file list." } },
          { "n", "<c-c>", actions.toggle_files, { desc = "Toggle the file panel" } },
          { "n", "[x", actions.prev_conflict, { desc = "Go to the previous conflict" } },
          { "n", "]x", actions.next_conflict, { desc = "Go to the next conflict" } },
        },
      },
    })
  end,
}
