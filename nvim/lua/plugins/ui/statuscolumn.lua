local conditions = require("heirline.conditions")

local function is_virtual_line()
  return vim.v.virtnum < 0
end

local function is_wrapped_line()
  return vim.v.virtnum > 0
end

local function not_in_fold_range()
  return vim.fn.foldlevel(vim.v.lnum) <= 0
end

local function not_fold_start(line)
  line = line or vim.v.lnum
  return vim.fn.foldlevel(line) <= vim.fn.foldlevel(line - 1)
end

local function fold_opened(line)
  return vim.fn.foldclosed(line or vim.v.lnum) == -1
end

-- local function git_sign()
--   return vim.fn.sign_getplaced(
--         vim.api.nvim_get_current_buf(),
--         {
--           group = "gitsigns_vimfn_signs_",
--           lnum = vim.v.lnum
--         }
--       )[1].signs[1]
-- end

local Number = {
  { provider = "%=" },
  {
    provider = function()
      local lnum = tostring(vim.v.lnum)
      if is_virtual_line() then
        return string.rep(" ", #lnum)
      elseif is_wrapped_line() then
        return " " .. string.rep(" ", #lnum)
      else
        return (#lnum == 1 and "  " or " ") .. lnum
      end
    end
  },
  { provider = " " }
}

local Fold = {
  provider = function()
    if is_wrapped_line() or is_virtual_line() then
      return ""
    elseif not_in_fold_range() or not_fold_start() then
      return "  "
    elseif fold_opened() then
      return Icons.misc.expanded
    else
      return Icons.misc.collapsed
    end
  end,
  hl = {
    fg   = Colors.grey_light,
    bg   = Colors.bg0,
    bold = true
  },
  on_click = {
    name = "heirline_fold_click_handler",
    callback = function()
      local line = vim.fn.getmousepos().line

      if not_fold_start(line) then
        return
      end

      vim.cmd.execute("'" .. line .. "fold" .. (fold_opened(line) and "close" or "open") .. "'")
    end
  }
}

local Border = {
  init     = function(self)
    local sign = vim.fn.sign_getplaced(
      vim.api.nvim_get_current_buf(),
      { group = "gitsigns_vimfn_signs_", lnum = vim.v.lnum }
    )[1].signs[1]

    self.highlight = sign and sign.name
  end,
  provider = Icons.misc.v_border,
  hl       = function(self)
    return self.highlight or "StatusColumnBorder"
  end
}

local Padding = {
  provider = " ",
  hl = function()
    if not conditions.is_active() then
      return { bg = Colors.bg15 }
    elseif vim.v.lnum == vim.fn.getcurpos()[2] then
      return { bg = Colors.line_purple }
    else
      return { bg = Colors.bg1 }
    end
  end
}

return { Number, Fold, Border, Padding }
