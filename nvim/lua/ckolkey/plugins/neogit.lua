return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dev = true,
  keys = {
    { "<leader>gg", ":Neogit<cr>", desc = "Neogit" },
    {
      "<leader>gf",
      function()
        require("neogit").action("log", "log_current", { "--", vim.fn.expand("%") })()
      end,
      desc = "Git log for file",
    },
    {
      "<leader>gf",
      function()
        local file = vim.fn.expand("%")
        vim.cmd([[execute "normal! \<ESC>"]])
        local line_start = vim.fn.getpos("'<")[2]
        local line_end = vim.fn.getpos("'>")[2]

        require("neogit").action("log", "log_current", { "-L" .. line_start .. "," .. line_end .. ":" .. file })()
      end,
      desc = "Git log for this range",
      mode = "v",
    },
  },
  opts = {
    mappings = {
      popup = {
        ["F"] = "PullPopup",
        ["p"] = false,
      },
      rebase_editor = {
        ["<c-d>"] = "Abort",
        ["<c-c><c-k>"] = false,
      },
      commit_editor = {
        ["<c-d>"] = "Abort",
        ["<c-c><c-k>"] = false,
      },
    },
    console_timeout = 10000,
    telescope_sorter = function()
      return require("telescope").extensions.fzf.native_fzf_sorter()
    end,
    fetch_after_checkout = true,
    auto_show_console = true,
    disable_hint = true,
    notification_icon = " ",
    status = {
      show_head_commit_hash = false,
    },
    sections = {
      rebase = {
        folded = false,
      },
      recent = {
        folded = false,
      },
    },
    signs = {
      section = { Icons.misc.collapsed, Icons.misc.expanded },
      item = { "", "" },
      hunk = { "", "" },
    },
  },
}
