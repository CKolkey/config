return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dev = true,
  keys = {
    { "<leader>gg", ":Neogit<cr>", desc = "Neogit" },
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
    filewatcher = {
      enabled = true,
    },
    fetch_after_checkout = true,
    auto_show_console = true,
    disable_hint = true,
    notification_icon = " ",
    disable_insert_on_commit = "auto",
    use_per_project_settings = true,
    remember_settings = true,
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
