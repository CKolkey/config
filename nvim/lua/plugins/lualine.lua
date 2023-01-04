return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,

      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,

      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local config = {
      options = {
        disabled_filetypes = { "neotree" },
        globalstatus = true,
        component_separators = "",
        section_separators = "",
        theme = {
          normal = { c = { fg = Colors.fg, bg = Colors.bg0 } },
          inactive = { c = { fg = Colors.fg, bg = Colors.bg0 } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    local function mode_color()
      local color_table = {
        n = Colors.green,
        i = Colors.blue,
        v = Colors.purple,
        [""] = Colors.purple,
        V = Colors.purple,
        c = Colors.orange,
        no = Colors.red,
        s = Colors.orange,
        S = Colors.orange,
        [""] = Colors.orange,
        ic = Colors.yellow,
        R = Colors.red,
        Rv = Colors.red,
        cv = Colors.red,
        ce = Colors.red,
        r = Colors.red,
        rm = Colors.red,
        ["r?"] = Colors.cyan,
        ["!"] = Colors.red,
        t = Colors.yellow,
      }

      return { fg = color_table[vim.fn.mode()] }
    end

    local function buffer_git_diff()
      local diff = vim.b.gitsigns_status_dict

      if diff then
        return { added = diff.added, modified = diff.changed, removed = diff.removed }
      else
        return {}
      end
    end

    -- Cool, but kinda dumb too
    -- local function visual_progress()
    --   local chars = { "▔▔", "🭶🭶", "🭷🭷", "🭸🭸", "🭹🭹", "🭺🭺", "🭻🭻", "▁▁" }
    --   local current_line = vim.fn.line(".")
    --   local total_lines = vim.fn.line("$")
    --   local line_ratio = current_line / total_lines
    --   local index = math.ceil(line_ratio * #chars)
    --
    --   return chars[index]
    -- end

    ins_left({
      function()
        return "▉"
      end,
      color = mode_color,
      padding = { left = 0, right = 1 },
    })

    ins_left({
      function()
        return "  "
      end,
      color = mode_color,
      padding = { right = 1 },
    })

    ins_left({
      "filesize",
      cond = conditions.buffer_not_empty,
    })

    ins_left({
      "filename",
      cond = conditions.buffer_not_empty,
      path = 1,
      color = { fg = Colors.purple },
    })

    ins_left({ "location" })

    ins_left({ "progress", color = { fg = Colors.fg } })

    -- ins_left { visual_progress, color = { fg = Colors.fg } }

    ins_left({
      "diagnostics",
      cond = conditions.buffer_not_empty,
      sources = { "nvim_diagnostic" },
      always_visible = true,
      symbols = {
        error = " " .. Icons.diagnostics.ERROR,
        warn = " " .. Icons.diagnostics.WARNING,
        info = " " .. Icons.diagnostics.INFO,
        hint = " " .. Icons.diagnostics.HINT,
      },
      padding = { left = 1 },
      diagnostics_color = {
        error = { fg = Colors.red },
        warn = { fg = Colors.yellow },
        info = { fg = Colors.blue },
        hint = { fg = Colors.green },
      },
    })

    -- -- Insert mid section
    -- ins_left {
    --   function()
    --     return '%='
    --   end,
    -- }

    ins_right({
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()

        if next(clients) == nil then
          return msg
        end

        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end

        return msg
      end,
      icon = " ",
      color = { fg = Colors.purple },
      cond = conditions.buffer_not_empty,
    })

    ins_right({
      "diff",
      colored = true,
      symbols = {
        added    = Icons.git.status_added,
        modified = Icons.git.status_modified,
        removed  = Icons.git.status_removed
      },
      cond = conditions.buffer_not_empty,
      diff_color = {
        added = { fg = Colors.green },
        modified = { fg = Colors.blue },
        removed = { fg = Colors.red },
      },
      source = buffer_git_diff,
    })

    ins_right({
      "branch",
      icon = " ",
      color = { fg = Colors.purple },
    })

    ins_right({
      function()
        return "🮋"
      end,
      color = mode_color,
      padding = { left = 1 },
    })

    lualine.setup(config)
  end,
}
