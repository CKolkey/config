if vim.g.status_column_built then
  return
end
vim.g.status_column_built = true
-- StatusColumn Fold-icon click handler
vim.cmd([[
  function! FoldColumn(minwid, clicks, button, mods)
    let s:lnum = getmousepos().line

    if foldlevel(s:lnum) > foldlevel(s:lnum - 1) " Only lines with the marks should be clickable
      if foldclosed(s:lnum) == -1
        execute s:lnum . "foldclose"
      else
        execute s:lnum . "foldopen"
      endif
    endif
  endfunction
]])

local sections = {
  [[ %=%{v:wrap ? "" : v:lnum} ]], -- Line Number
  { -- Folds
    [[%#FoldColumn#]], -- HL
    [[%@FoldColumn@]], -- Click Handler
    [[%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  ") : "  " }]]
  },
  [[%s]], -- Sign Column
  -- { -- Border
  --   [[%#StatusColumnBorder#]], -- HL
  --   [[┃]],
  -- },
}

-- Have this in an autocmd on WinCreate (whatever is when you enter a window for the first time) to build the proper
-- column based on the filetype, or buffertype, or something
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

vim.opt.statuscolumn = build_statuscolumn(sections)
