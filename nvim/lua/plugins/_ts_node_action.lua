local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")

local function toggle_boolean(node)
  local start_row, start_col, end_row, end_col = node:range()
  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { tostring(node:type() ~= "true") })
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
  local view = vim.fn.winsaveview()
  local fn

  if start_row == end_row then
    require("trevj").format_at_cursor()
  else
    vim.api.nvim_buf_set_text(0, start_row, start_col + 1, end_row, end_col - 1, collapse_child_nodes(node))
  end

  vim.fn.winrestview(view)
end

local function cycle_case(node)
  local start_row, start_col, end_row, end_col = node:range()
  -- TODO: Cycle through camel, snake, kebab, pascal, title case for an identifier
  -- - Determine the current case of a node
  -- - convert that into a common format, probably something like: { 'words', 'in', 'a', 'list' }
  -- - convert that common format into the 'next' version (remember to hold onto which format you started with)
  --
  local text = vim.treesitter.query.get_node_text(node, 0)
  local words
  local format

  local formats = {
    function(tbl) -- to_snake_case
      return string.lower(table.concat(tbl, "_"))
    end,

    function(tbl) -- toCamelCase
      local tmp = vim.tbl_map(function(word)
        return word:gsub("^.", string.upper)
      end, tbl)
      local value, _ = table.concat(tmp, ""):gsub("^.", string.lower)
      return value
    end,
  }

  if string.find(text, "_") then
    -- We're in snake_case
    words = vim.split(string.lower(text), "_", { trimempty = true })
    format = 2
  else
    -- Lets presume camelCase for now
    words = vim.split(
      text:gsub(".%f[%l]", " %1"):gsub("%l%f[%u]", "%1 "):gsub("^.", string.upper),
      " ",
      { trimempty = true }
    )
    format = 1
  end

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { formats[format](words) })
end

local function toggle_block(node)
  local start_row, start_col, end_row, end_col = node:range()

  local block_params
  local block_body
  local replacement

  for child, _ in node:iter_children() do
    local node_text = vim.treesitter.query.get_node_text(child, 0)
    if child:type() == "block_parameters" then
      block_params = node_text
    end

    if child:type() == "block_body" or child:type() == "body_statement" then
      block_body = node_text
    end
  end

  if start_row == end_row then
    replacement = { "do " .. block_params, "  " .. block_body, "end" }
  else
    block_body = table.concat(vim.split(block_body, "\n", { trimempty = true }), "; ")
    replacement = { "{ " .. block_params .. " " .. block_body .. " }" }
  end

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, replacement)
  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
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
    ["block"] = toggle_block,
    ["do_block"] = toggle_block,
  }
}

function M.node_action()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return
  end

  local filetype = vim.o.filetype
  local action = node_actions[filetype][node:type()]
  if action then
    action(node)
  else
    print("(TS:Action) No action defined for " .. filetype .. " node type: '" .. node:type() .. "'")
  end
end

return M
