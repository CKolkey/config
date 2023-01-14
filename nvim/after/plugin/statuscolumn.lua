if _G.StatusColumn then
  return
end

_G.StatusColumn = {
  handler = {
    fold = function()
      local lnum = vim.fn.getmousepos().line

      -- Only lines with a mark should be clickable
      if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
        return
      end

      local state
      if vim.fn.foldclosed(lnum) == -1 then
        state = "close"
      else
        state = "open"
      end

      vim.cmd.execute("'" .. lnum .. "fold" .. state .. "'")
    end
  },
  display = {
    fold = function()
      local lnum = vim.v.lnum
      local icon = "  "

      -- Line isn't in folding range
      if vim.fn.foldlevel(lnum) <= 0 then
        return icon
      end

      -- Not the first line of folding range
      if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
        return icon
      end

      if vim.fn.foldclosed(lnum) == -1 then
        icon = Icons.misc.expanded
      else
        icon = Icons.misc.collapsed
      end

      return icon
    end
  }
}

local sign_column = {
  [[%s]]
}

-- vim.v.wrap
local line_number = {
  [[%=%{v:wrap ? "" : v:lnum}]]
}

local spacing = {
  [[ ]]
}

local folds = {
  [[%#FoldColumn#]], -- HL
  [[%@v:lua.StatusColumn.handler.fold@]],
  [[%{v:lua.StatusColumn.display.fold()}]]
}

local border = {
  [[%#StatusColumnBorder#]], -- HL
  [[▐]],
}

local padding = {
  [[%#StatusColumnBuffer#]], -- HL
  [[ ]],
}

local function build_statuscolumn(tbl)
  local statuscolumn = {}

  for _, value in ipairs(tbl) do
    if type(value) == "string" then
      table.insert(statuscolumn, value)
    elseif type(value) == "table" then
      table.insert(statuscolumn, build_statuscolumn(value))
    end
  end

  return table.concat(statuscolumn)
end

vim.opt.statuscolumn = build_statuscolumn({ sign_column, line_number, spacing, folds, border, padding })
