local M = {}

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

M.config = function()
  require("neogit").setup({
    disable_hint = true,
    disable_commit_confirmation = false,
    disable_insert_on_commit = false,
    kind = "vsplit",
    signs = {
      section = { " ", " " },
      item = { " ", " " },
    },
    integrations = {
      -- diffview = true,
    },
    mappings = {
      status = {
        [" "] = "Toggle",
        ["l"] = "Toggle",
        ["h"] = "Toggle",
        ["B"] = git_branches,
        ["b"] = git_branches,
      },
    },
  })
end

return M
