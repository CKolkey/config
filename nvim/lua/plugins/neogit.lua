return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dev = true,
  opts = {
    console_timeout = 10000,
    telescope_sorter = function()
      return require("telescope").extensions.fzf.native_fzf_sorter()
    end,
    auto_show_console = true,
    disable_hint = true,
    disable_commit_confirmation = true,
    disable_insert_on_commit = "auto",
    kind = "tab",
    use_per_project_settings = true,
    remember_settings = true,
    -- mappings = {
    --   status = {
    --     ["s"] = false,
    --   },
    -- },
    signs = {
      section = { Icons.misc.collapsed, Icons.misc.expanded },
      item = { Icons.misc.collapsed, Icons.misc.expanded },
    },
    commit_editor = {
      kind = "auto",
    },
    rebase_editor = {
      kind = "auto",
    },
    merge_editor = {
      kind = "auto",
    },
  },
}
