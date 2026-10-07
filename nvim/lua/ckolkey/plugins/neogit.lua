vim.g.diffs = {
  neogit = true,
}

return {
  "NeogitOrg/neogit",
  dependencies = {
    -- "barrettruth/diffs.nvim",
    -- {
    --   "m00qek/baleia.nvim",
    --   version = "*",
    --   config = function()
    --     vim.g.baleia = require("baleia").setup({})
    --
    --     -- Command to colorize the current buffer
    --     vim.api.nvim_create_user_command("BaleiaColorize", function()
    --       vim.g.baleia.once(vim.api.nvim_get_current_buf())
    --     end, { bang = true })
    --
    --     -- Command to show logs
    --     vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
    --   end,
    -- }
  },
  cmd = "Neogit",
  dev = true,
  lazy = true,
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
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
    -- NOTE: for msgarea plugin
    -- popup = { kind = "floating", show_title = false },
    -- floating = {
    --   relative = "msgarea",
    --   height = 0.33,
    --   border = "none",
    -- },
    process_spinner = true,
    diff_viewer = "codediff",
    mappings = {
      popup = {
        ["F"] = "PullPopup",
        ["p"] = false,
      },
      -- log_view = {
      --   ["<esc>"] = false,
      -- },
      rebase_editor = {
        ["<c-d>"] = "Abort",
        ["<c-c><c-k>"] = false,
        ["<m-j>"] = "MoveDown",
        ["<m-k>"] = "MoveUp",
      },
      commit_editor = {
        ["<c-d>"] = "Abort",
        ["<c-c><c-k>"] = false,
      },
    },
    commit_view = {
      verify_commit = false,
    },
    graph_style = "kitty",
    fetch_after_checkout = true,
    disable_hint = true,
    notification_icon = " ",
    status = {
      show_head_commit_hash = true,
    },
    sections = {
      rebase = {
        folded = false,
      },
      recent = {
        folded = false,
      },
      -- todo = {
      --   keywords = {
      --     ["TODO"] = "NeogitGraphBoldBlue",
      --     ["NOTE"] = "NeogitGraphBoldGreen",
      --   },
      -- },
    },
    signs = {
      section = { Icons.misc.collapsed, Icons.misc.expanded },
      item = { "", "" },
      hunk = { "", "" },
    },
    builders = {
      ---@param builder PopupBuilder
      NeogitTagPopup = function(builder)
        builder:action_if(
          vim.uv.cwd():match("karnov") ~= nil,
          "d",
          "deploy to production",
          function(popup)
            local notification = require("neogit.lib.notification")
            local FuzzyFinderBuffer = require("neogit.buffers.fuzzy_finder")
            local git = require("neogit.lib.git")
            local input = require("neogit.lib.input")

            local selected
            if popup.state.env.commit then
              local maybe_tag = git.tag.for_commit(popup.state.env.commit)[1]
              if maybe_tag and maybe_tag:match("^staging%-%d+$") then
                selected = maybe_tag
              end
            end

            if not selected then
              selected = FuzzyFinderBuffer.new(vim.fn.reverse(git.tag.list("staging-*"))):open_async {
                prompt_prefix = "Deploy to production"
              }
            end

            if selected and input.get_permission("Deploy " .. selected .. " to prod?") then
              notification.info("Deploying " .. selected .. " to production")
              local on_exit = function(obj)
                if obj.code == 0 then
                  notification.info("Done")
                  vim.defer_fn(require("neogit").dispatch_refresh, 1000)
                else
                  notification.warn("Jin encountered an error")
                end
              end

              vim.system({ "jin", "deploy", selected }, on_exit)
            end
          end)
      end
    }
  },
}
