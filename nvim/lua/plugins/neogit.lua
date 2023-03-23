return {
  "ckolkey/neogit",
  cmd = "Neogit",
  dev = true,
  init = function()
    local instance = require("notify").instance(
      { timeout = 800, background_colour = "NeogitNotification", top_down = false, stages = "fade_in_slide_out" }
    )

    require("neogit.lib.notification").create = function(message, level)
      local timeout
      if level then
        timeout = 5000
      end

      instance.notify(message, level or vim.log.levels.INFO, { title = "Neogit", icon = " ", timeout = timeout })
    end
  end,
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
      telescope = true,
    },
    signs                       = {
      section = { Icons.misc.collapsed, Icons.misc.expanded },
      item    = { Icons.misc.collapsed, Icons.misc.expanded },
    },
    commit_popup = {
      kind = "vsplit"
    },
    mappings                    = {
      status = {
        [" "] = "Toggle",
        ["l"] = "Toggle",
        ["h"] = "Toggle",
        ["z"] = "StashPopup",
      },
    }
  }
}
