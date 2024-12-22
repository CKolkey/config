return {
  "NeogitOrg/neogit",
  dependencies = {
    {
      "m00qek/baleia.nvim",
      version = "*",
      config = function()
        vim.g.baleia = require("baleia").setup({})

        -- Command to colorize the current buffer
        vim.api.nvim_create_user_command("BaleiaColorize", function()
          vim.g.baleia.once(vim.api.nvim_get_current_buf())
        end, { bang = true })

        -- Command to show logs
        vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
      end,
    }
  },
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
    -- log_pager = { 'delta', '--width', '117', '--line-numbers', '--no-gitconfig', '--color-only' },
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
    commit_view = {
      verify_commit = false,
    },
    graph_style = "kitty",
    fetch_after_checkout = true,
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
  },
}
