local git_branches = function()
  require("telescope.builtin").git_branches({
    layout_config = {
      height = 25,
      prompt_position = "top",
      preview_cutoff = 120,
      width = 0.5,
    },
    border = true,
    prompt_prefix = "  ",
    prompt_title = "Branches",
    previewer = false,
    layout_strategy = "vertical",
    sorting_strategy = "ascending",
    theme = "ivy",
  })
end

return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  opts = {
    console_timeout = 5000,
    auto_show_console = true,
    disable_hint = true,
    disable_commit_confirmation = true,
    disable_insert_on_commit = false,
    kind = "vsplit",
    integrations = {
      diffview = true,
    },
    signs = {
      section = { Icons.misc.collapsed, Icons.misc.expanded },
      item    = { Icons.misc.collapsed, Icons.misc.expanded },
    },
    mappings = {
      status = {
        [" "] = "Toggle",
        ["l"] = "Toggle",
        ["h"] = "Toggle",
        ["B"] = git_branches,
        ["b"] = git_branches,
      },
    }
  }
}
