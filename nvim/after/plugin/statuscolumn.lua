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
    line = function()
      if vim.v.wrap then
        return ""
      end

      local lnum = tostring(vim.v.lnum)
      if #lnum == 1 then -- Prevent adding a tenth line from bumping the size of the column
        return " " .. lnum
      else
        return lnum
      end
    end,

    fold = function()
      if vim.v.wrap then
        return ""
      end

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
  },

  sections = {
    sign_column = {
      [[%s]]
    },
    line_number = {
      [[%=%{v:lua.StatusColumn.display.line()}]]
    },
    spacing     = {
      [[ ]]
    },
    folds       = {
      [[%#FoldColumn#]], -- HL
      [[%@v:lua.StatusColumn.handler.fold@]],
      [[%{v:lua.StatusColumn.display.fold()}]]
    },
    border      = {
      [[%#StatusColumnBorder#]], -- HL
      [[▐]],
    },
    padding     = {
      [[%#StatusColumnBuffer#]], -- HL
      [[ ]],
    },
  },

  build = function(tbl)
    local statuscolumn = {}

    for _, value in ipairs(tbl) do
      if type(value) == "string" then
        table.insert(statuscolumn, value)
      elseif type(value) == "table" then
        table.insert(statuscolumn, StatusColumn.build(value))
      end
    end

    return table.concat(statuscolumn)
  end,

  set_window = function(value)
    vim.defer_fn(function()
      vim.api.nvim_win_set_option(vim.api.nvim_get_current_win(), "statuscolumn", value)
    end, 1)
  end
}

vim.opt.statuscolumn = StatusColumn.build({
  StatusColumn.sections.sign_column,
  StatusColumn.sections.line_number,
  StatusColumn.sections.spacing,
  StatusColumn.sections.folds,
  StatusColumn.sections.border,
  StatusColumn.sections.padding
})
