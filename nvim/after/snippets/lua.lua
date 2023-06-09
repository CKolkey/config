local M = {}

M.snippets = {}

M.autosnippets = {
	["!="] = {
		description = "Fix dumb lua not-equals operator",
		"~=",
	},
	["if "] = {
		description = "if ... then~",
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
		"if ",
		i(1),
		" then",
		indent(), i(2),
		newline("end"),
	},
}

return M
