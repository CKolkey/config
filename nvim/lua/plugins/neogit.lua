return {
  "ckolkey/neogit",
  cmd = "Neogit",
  dev = true,
  opts = {
    console_timeout             = 10000,
    auto_show_console           = true,
    disable_hint                = true,
    disable_commit_confirmation = true,
    disable_insert_on_commit    = true,
    kind                        = "tab",
    use_per_project_settings    = true,
    remember_settings           = true,
    ignored_settings             = {
      "NeogitPushPopup--force-with-lease",
      "NeogitPushPopup--force",
      "NeogitCommitPopup--allow-empty",
    },
    integrations                = {
      diffview = true,
    },
    signs                       = {
      section = { Icons.misc.collapsed, Icons.misc.expanded },
      item    = { Icons.misc.collapsed, Icons.misc.expanded },
    },
    commit_popup = {
      kind = "auto"
    },
    mappings                    = {
      status = {
        ["l"] = "Toggle",
        ["h"] = "Toggle",
      },
    }
  }
}
