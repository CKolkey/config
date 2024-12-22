local conditions = require("heirline.conditions")
local foldlevel = vim.fn.foldlevel
local foldclosed = vim.fn.foldclosed
local getcurpos = vim.fn.getcurpos
local getpos = vim.fn.getpos
local nvim_win_get_cursor = vim.api.nvim_win_get_cursor

local CURSOR_LINE_NR = "CursorLineNr"
local LINE_TEMPLATE = "%s%s"

local function lnum_places()
  local lnum = vim.v.lnum
  if lnum < 10 then
    return 1
  elseif lnum < 100 then
    return 2
  elseif lnum < 1000 then
    return 3
  elseif lnum < 10000 then
    return 4
  else
    return 5
  end
end

local function is_virtual_line()
  return vim.v.virtnum < 0
end

local function is_wrapped_line()
  return vim.v.virtnum > 0
end

local function not_in_fold_range()
  return foldlevel(vim.v.lnum) <= 0
end

local function not_fold_start(line)
  return foldlevel(line) <= foldlevel(line - 1)
end

local function fold_opened(line)
  return foldclosed(line or vim.v.lnum) == -1
end

local padding = { " ", "  ", "   ", "    ", "     " }
local wrapped = { "  ", "   ", "    ", "     ", "      " }
local lines = {}
for i = 1, 10000 do
  table.insert(lines, (LINE_TEMPLATE):format(i < 10 and "  " or " ", i))
end

local Number = {
  { provider = "%=" },
  {
    init = function(self)
      self.visual_range = nil
      self.lnum = vim.v.lnum

      local mode = vim.fn.mode()
      if mode:match("V") or mode:match("v") or mode:match("") then
        local visual_lnum = getpos("v")[2]
        local cursor_lnum = nvim_win_get_cursor(0)[1]

        self.visual_range = { cursor_lnum, visual_lnum }
        table.sort(self.visual_range)
      end
    end,
    hl = function(self)
      if self.visual_range then
        if self.lnum >= self.visual_range[1] and self.lnum <= self.visual_range[2] then
          return CURSOR_LINE_NR
        end
      end
    end,
    provider = function(self)
      if is_virtual_line() then
        return padding[lnum_places()]
      elseif is_wrapped_line() then
        return wrapped[lnum_places()]
      else
        return lines[self.lnum] or (" %s"):format(self.lnum)
      end
    end,
  },
  { provider = " " },
}

local Fold = {
  provider = function()
    if is_wrapped_line() or is_virtual_line() then
      return ""
    elseif not_in_fold_range() or not_fold_start(vim.v.lnum) then
      return "  "
    elseif fold_opened() then
      return Icons.misc.expanded
    else
      return Icons.misc.collapsed
    end
  end,
  hl = {
    fg = Colors.grey_light,
    bg = Colors.bg0,
    bold = true,
  },
  on_click = {
    name = "heirline_fold_click_handler",
    callback = function()
      local line = vim.fn.getmousepos().line

      if not_fold_start(line) then
        return
      end

      vim.cmd.execute("'" .. line .. "fold" .. (fold_opened(line) and "close" or "open") .. "'")
    end,
  },
}

local Border = {
  init = function(self)
    local ns_id = vim.api.nvim_get_namespaces()["gitsigns_signs_"]
    if ns_id then
      local marks = vim.api.nvim_buf_get_extmarks(
        0,
        ns_id,
        { vim.v.lnum - 1, 0 },
        { vim.v.lnum, 0 },
        { limit = 1, details = true }
      )

      if #marks > 0 then
        local hl_group = marks[1][4]["sign_hl_group"]
        self.highlight = hl_group
      else
        self.highlight = nil
      end
    end
  end,
  provider = Icons.misc.v_border,
  hl = function(self)
    return self.highlight or "StatusColumnBorder"
  end,
}

local Padding = {
  provider = " ",
  hl = function()
    if not conditions.is_active() then
      return { bg = Colors.bg15 }
    elseif vim.v.lnum == getcurpos()[2] then
      return { bg = Colors.cursor_line }
    else
      return { bg = Colors.bg1 }
    end
  end,
}

return {
  Number,
  Fold,
  Border,
  Padding
}
