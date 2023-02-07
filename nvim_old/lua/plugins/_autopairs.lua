local M = {}

M.config = function()
  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  local ts_conds = require("nvim-autopairs.ts-conds")

  npairs.setup({
    map_bs = true,
    map_cr = true,
    check_ts = true,
    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
  })

  -- Adding space inside brackets
  npairs.add_rules({
    Rule(" ", " "):with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end),

    Rule("#", "{}", "ruby")
      :with_pair(ts_conds.is_ts_node({ 'string' }))
      :set_end_pair_length(1),

    Rule("|", "|", "ruby")
      :with_pair(function()
        return true
      end)
      :with_move(function(opts)
        return opts.prev_char:match("|") ~= nil
      end)
      :use_key("|"),

    Rule("( ", " )")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match(".%)") ~= nil
      end)
      :use_key(")"),

    Rule("{ ", " }")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match(".%}") ~= nil
      end)
      :use_key("}"),

    Rule("[ ", " ]")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match(".%]") ~= nil
      end)
      :use_key("]"),
  })
end

return M
