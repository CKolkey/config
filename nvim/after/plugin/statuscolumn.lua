if _G.StatusColumn then
  return
end

_G.StatusColumn = {}

StatusColumn.set_window = function(value, defer, win)
  vim.defer_fn(function()
    win = win or vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_option(win, "statuscolumn", value)
  end, defer or 1)
end

local function is_virtual_line()
  return vim.v.virtnum < 0
end

local function is_wrapped_line()
  return vim.v.virtnum > 0
end

local function not_in_fold_range()
  return vim.fn.foldlevel(vim.v.lnum) <= 0
end

local function not_fold_start()
  return vim.fn.foldlevel(vim.v.lnum) <= vim.fn.foldlevel(vim.v.lnum - 1)
end

local function fold_opened()
  return vim.fn.foldclosed(vim.v.lnum) == -1
end

local function line_number()
  local lnum = tostring(vim.v.lnum)
  if is_virtual_line() then
    return string.rep(" ", #lnum)
  elseif is_wrapped_line() then
    return " " .. string.rep(" ", #lnum)
  else
    return (#lnum == 1 and " " or "") .. lnum
  end
end

local function fold_icon()
  if is_wrapped_line() or is_virtual_line() then
    return ""
  end

  local icon
  if not_in_fold_range() or not_fold_start() then
    icon = "  "
  elseif fold_opened() then
    icon = Icons.misc.expanded
  else
    icon = Icons.misc.collapsed
  end

  return icon
end

local function border_highlight()
  local line_highlight = function(sign)
    if sign.name:find("GitSign") then
      return vim.fn.sign_getdefined(sign.name)[1].texthl
    end
  end

  local buf       = vim.api.nvim_get_current_buf()
  local signs     = vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs
  local highlight = vim.tbl_map(line_highlight, signs)[1]

  return highlight or "StatusColumnBorder"
end

local number = function()
  return { " %=", line_number(), " " }
end

local fold = function()
  return { "%#FoldColumn#", "%@v:lua.StatusColumn.handler.fold@", fold_icon() }
end

local border = function()
  return { "%#", border_highlight(), "#", Icons.misc.v_border, "%*" }
end

local padding = function()
  if vim.v.lnum == vim.fn.getcurpos()[2] then
    return { "%#StatusColumnBufferCursorLine#", " " }
  else
    return { "%#StatusColumnBuffer#", " " }
  end
end

StatusColumn.build = function()
  return table.concat(vim.tbl_flatten({ number(), fold(), border(), padding() }))
end

vim.opt.statuscolumn = [[%!v:lua.StatusColumn.build()]]
