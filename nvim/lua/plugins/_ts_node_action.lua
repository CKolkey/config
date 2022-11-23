local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")

local function toggle_boolean(node)
  local start_row, start_col, end_row, end_col = node:range()
  local replacement = { tostring(node:type() ~= "true") }
  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, replacement)
end

local function collapse_child_nodes(node)
  local replacement = {}
  for child, _ in node:iter_children() do
    if child:named() then
      table.insert(replacement, vim.treesitter.query.get_node_text(child, 0))
    end
  end

  return { table.concat(replacement, ", ") }
end

local function toggle_multiline(node)
  local start_row, start_col, end_row, end_col = node:range()

  if start_row == end_row then
    require("trevj").format_at_cursor()
  else
    vim.api.nvim_buf_set_text(0, start_row, start_col + 1, end_row, end_col - 1, collapse_child_nodes(node))
    vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
  end
end

local function cycle_case(node)
  local start_row, start_col, end_row, end_col = node:range()
  local text = vim.treesitter.query.get_node_text(node, 0)
  local words
  local format

  local formats = {
    ["toSnakeCase"] = function(tbl)
      return string.lower(table.concat(tbl, "_"))
    end,

    ["toCamelCase"] = function(tbl)
      local tmp = vim.tbl_map(function(word)
        return word:gsub("^.", string.upper)
      end, tbl)
      local value, _ = table.concat(tmp, ""):gsub("^.", string.lower)
      return value
    end,

    ["toPascalCase"] = function(tbl)
      local tmp = vim.tbl_map(function(word)
        return word:gsub("^.", string.upper)
      end, tbl)
      local value, _ = table.concat(tmp, "")
      return value
    end,

    ["toYellingCase"] = function(tbl)
      local tmp = vim.tbl_map(function(word)
        return word:upper()
      end, tbl)
      local value, _ = table.concat(tmp, "_")
      return value
    end,
  }

  if (string.find(text, "_") and string.sub(text, 1, 1) == string.sub(text, 1, 1):lower()) or text:lower() == text then -- snake_case
    words = vim.split(string.lower(text), "_", { trimempty = true })
    format = formats.toPascalCase
  elseif string.sub(text, 1, 2) == string.sub(text, 1, 2):upper() then -- YELLING_CASE
    words = vim.split(string.lower(text), "_", { trimempty = true })
    format = formats.toCamelCase
  elseif string.sub(text, 1, 1) == string.sub(text, 1, 1):upper() then -- PascalCase
    words = vim.split(
      text:gsub(".%f[%l]", " %1"):gsub("%l%f[%u]", "%1 "):gsub("^.", string.upper),
      " ",
      { trimempty = true }
    )
    format = formats.toYellingCase
  else -- camelCase
    words = vim.split(
      text:gsub(".%f[%l]", " %1"):gsub("%l%f[%u]", "%1 "):gsub("^.", string.upper),
      " ",
      { trimempty = true }
    )
    format = formats.toSnakeCase
  end

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { format(words) })
end

-- TODO: Get correct indent for line
local function toggle_block(node)
  local start_row, start_col, end_row, end_col = node:range()

  local block_params
  local block_body   = ""
  local replacement

  for child, _ in node:iter_children() do
    local node_text = vim.treesitter.query.get_node_text(child, 0)
    if child:type() == "block_parameters" then
      block_params = " " .. node_text
    end

    if child:type() == "block_body" or child:type() == "body_statement" then
      block_body = node_text
    end
  end

  if start_row == end_row then
    if block_params then
      replacement = { "do" .. block_params, "  " .. block_body, "end" }
    else
      replacement = { "do", "  " .. block_body, "end" }
    end
  else
    block_body = table.concat(vim.split(block_body, "\n", { trimempty = true }), "; ")
    if block_params then
      replacement = { "{" .. block_params .. " " .. block_body .. " }" }
    else
      replacement = { "{ " .. block_body .. " }" }
    end
  end

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, replacement)
  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
end

local function toggle_comparison(node)
  local start_row, start_col, end_row, end_col = node:range()

  local translations = {
    ["!="] = "==",
    ["=="] = "!=",
    [">"] = "<",
    ["<"] = ">",
    [">="] = "<=",
    ["<="] = ">=",
  }

  local replacement = {}

  for child, _ in node:iter_children() do
    local child_text = vim.treesitter.query.get_node_text(child, 0)
    if translations[child_text] then
      table.insert(replacement, translations[child_text])
    else
      table.insert(replacement, child_text)
    end
  end

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { table.concat(replacement, " ") })
end

local function inline_conditional(node)
  local start_row, start_col, end_row, end_col = node:range()

  local body
  local condition

  for child, _ in node:iter_children() do
    local child_text = vim.treesitter.query.get_node_text(child, 0)
    if child:type() == "then" then
      body = child_text:gsub("^%s+", "")
    end

    if child:type() ~= "if" and child:type() ~= "then" and child:type() ~= "end" then
      condition = child_text
    end
  end

  local replacement = { body .. " if " .. condition }

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, replacement)
  vim.api.nvim_win_set_cursor(0, { start_row + 1, #body + 1 })
end

local function multiline_conditional(node)
  local start_row, start_col, end_row, end_col = node:range()

  local capture_body = true
  local body
  local condition

  for child, _ in node:iter_children() do
    local child_text = vim.treesitter.query.get_node_text(child, 0)

    if child:type() == "if" then
      capture_body = false
    end

    if capture_body then
      body = child_text
    end

    if not capture_body then
      condition = child_text
    end
  end

  local replacement = { "if " .. condition, "  " .. body, "end" }

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, replacement)
  vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
end

local function toggle_ternary(node)
  local start_row, start_col, end_row, end_col = node:range()

  for child, _ in node:iter_children() do
    local child_text = vim.treesitter.query.get_node_text(child, 0)
    print(child:type() .. " | " .. child_text)
  end
end

local node_actions = {
  lua = {
    ["table_constructor"] = toggle_multiline,
  },
  ruby = {
    ["true"] = toggle_boolean,
    ["false"] = toggle_boolean,
    ["array"] = toggle_multiline,
    ["hash"] = toggle_multiline,
    ["argument_list"] = toggle_multiline,
    ["method_parameters"] = toggle_multiline,
    ["identifier"] = cycle_case,
    ["constant"] = cycle_case,
    ["block"] = toggle_block,
    ["do_block"] = toggle_block,
    ["binary"] = toggle_comparison,
    ["if"] = inline_conditional,
    ["if_modifier"] = multiline_conditional,
    ["conditional"] = toggle_ternary
  }
}

function M.node_action()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    print("(TS:Action) Cursor must be over a TS node")
    return
  end

  local filetype = vim.o.filetype
  if not node_actions[filetype] then
    print("(TS:Action) No actions defined for filetype: '" .. filetype .. "'")
    return
  end

  local action = node_actions[filetype][node:type()]
  if action then
    action(node)
  else
    print("(TS:Action) No action defined for " .. filetype .. " node type: '" .. node:type() .. "'")
  end
end

return M
