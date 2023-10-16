local M = {}

M.snippets = {}

M.autosnippets = {
  ["from "] = {
    description = "from ... import ...",
    condition = function()
      local ignored_nodes = { "string", "comment" }

      local pos = vim.api.nvim_win_get_cursor(0)
      -- Use one column to the left of the cursor to avoid a "chunk" node
      -- type. Not sure what it is, but it seems to be at the end of lines in
      -- some cases.
      local row, col = pos[1] - 1, pos[2] - 1

      local node_type = vim.treesitter.get_node({ pos = { row, col } }):type()
      return not vim.tbl_contains(ignored_nodes, node_type)
    end,
    "from ", i(1), " import ", i(2),
  },
  ["__init"] = {
    description = "__init__(self, )",
    "__init__(self, ", i(1), "):", indent(), i(2),
  },
  ["__call"] = {
    description = "__call__(self, )",
    "__call__(self, ", i(1), "):", indent(), i(2),
  }

}

return M
