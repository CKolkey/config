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
    },
    auto_fetch_on_refresh = true,
    console_timeout = 10000,
    telescope_sorter = function()
      return require("telescope").extensions.fzf.native_fzf_sorter()
    end,
    filewatcher = {
      enabled = true,
    },
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
      item = { Icons.misc.collapsed, Icons.misc.expanded },
    },
  },
}
