local M = {}

local lualine = require("lualine")

local colors = require("colors").colors
local icons = require("colors").icons

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
      normal = { c = { fg = colors.fg, bg = colors.bg0 } },
      inactive = { c = { fg = colors.fg, bg = colors.bg0 } },
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
    n = colors.green,
    i = colors.blue,
    v = colors.purple,
    [""] = colors.purple,
    V = colors.purple,
    c = colors.orange,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [""] = colors.orange,
    ic = colors.yellow,
    R = colors.red,
    Rv = colors.red,
    cv = colors.red,
    ce = colors.red,
    r = colors.red,
    rm = colors.red,
    ["r?"] = colors.cyan,
    ["!"] = colors.red,
    t = colors.yellow,
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
  color = { fg = colors.purple },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg } })

-- ins_left { visual_progress, color = { fg = colors.fg } }

ins_left({
  "diagnostics",
  cond = conditions.buffer_not_empty,
  sources = { "nvim_diagnostic" },
  always_visible = true,
  symbols = {
    error = " " .. icons.error,
    warn = " " .. icons.warning,
    info = " " .. icons.info,
    hint = " " .. icons.hint,
  },
  padding = { left = 1 },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.blue },
    hint = { fg = colors.green },
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
  color = { fg = colors.purple },
  cond = conditions.buffer_not_empty,
})

ins_right({
  "diff",
  colored = true,
  symbols = { added = icons.added, modified = icons.modified, removed = icons.removed },
  cond = conditions.buffer_not_empty,
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.blue },
    removed = { fg = colors.red },
  },
  source = buffer_git_diff,
})

ins_right({
  "branch",
  icon = " ",
  color = { fg = colors.purple },
})

ins_right({
  function()
    return "🮋"
  end,
  color = mode_color,
  padding = { left = 1 },
})

M.config = function()
  lualine.setup(config)
end

return M
