local M = {}

M.snippets = {
  ["fn"] = {
    description = "function",
    "function ",
    i(1),
    "(",
    i(2),
    ")",
    indent(),
    i(0),
    newline("end"),
  },
  -- ["for"] = {
  --   description = "for",
  --   "for ",
  --   i(1),
  --   " = ",
  --   i(2),
  --   ", ",
  --   i(3),
  --   " do",
  --   indent(),
  --   i(0),
  --   newline("end"),
  -- },
  ["fori"] = {
    description = "for i = 1, #",
    "for ",
    i(1),
    " = 1, #",
    i(2),
    " do",
    indent(),
    i(0),
    newline("end"),
  },
  -- ["forip"] = {
  --   description = "for i = #, 1, -1",
  --   "for ",
  --   i(1),
  --   " = #, 1, -1 do",
  --   indent(),
  --   i(0),
  --   newline("end"),
  -- },
  ["forip"] = {
    description = "for _, _ in ipairs()",
    "for _, ",
    i(1),
    " in ipairs(",
    i(2),
    ") do",
    indent(),
    i(0),
    newline("end"),
  },
  ["forp"] = {
    description = "for _ in pairs()",
    "for _, ",
    i(1),
    " in pairs(",
    i(2),
    ") do",
    indent(),
    i(0),
    newline("end"),
  },
  ["if"] = {
    description = "if",
    "if ",
    i(1),
    " then",
    indent(),
    i(0),
    newline("end"),
  },
  ["ife"] = {
    description = "if ... else",
    "if ",
    i(1),
    " then",
    indent(),
    i(0),
    newline("else"),
    indent(),
    i(),
    newline("end"),
  },
}

M.autosnippets = {
  ["!="] = {
    description = "Fix dumb lua not-equals operator",
    "~=",
  },
  -- ["if "] = {
  --   description = "if ... then~",
  --   condition = function()
  --     local ignored_nodes = { "string", "comment" }
  --
  --     local pos = vim.api.nvim_win_get_cursor(0)
  --     -- Use one column to the left of the cursor to avoid a "chunk" node
  --     -- type. Not sure what it is, but it seems to be at the end of lines in
  --     -- some cases.
  --     local row, col = pos[1] - 1, pos[2] - 1
  --
  --     local node_type = vim.treesitter.get_node({ pos = { row, col } }):type()
  --     return not vim.tbl_contains(ignored_nodes, node_type)
  --   end,
  --   "if ",
  --   i(1),
  --   " then",
  --   indent(),
  --   i(2),
  --   newline("end"),
  -- },
}

return M
