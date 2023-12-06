local function count(base, pattern)
  return select(2, string.gsub(base, "%" .. pattern, ""))
end

local function check_line_balance(opts)
  local closes = count(opts.line, opts.rule.end_pair)
  local opens  = count(opts.line, opts.char)

  if closes == 0 then
    return true
  end

  return opens == closes
end

return {
  "windwp/nvim-autopairs",
  config = function()
    local auto_pairs = require("nvim-autopairs")
    local rule       = require("nvim-autopairs.rule")
    local ts_conds   = require("nvim-autopairs.ts-conds")

    auto_pairs.setup({
      map_bs           = true,
      map_cr           = true,
      check_ts         = true,
      fast_wrap        = {},
      disable_in_macro = true,
    })

    -- auto_pairs.remove_rule('(')
    -- auto_pairs.remove_rule('{')
    -- auto_pairs.remove_rule('[')

    auto_pairs.add_rules({
      -- rule("(", ")"):with_pair(check_line_balance),
      -- rule("[", "]"):with_pair(check_line_balance),
      -- rule("{", "}"):with_pair(check_line_balance),

      -- ERB
      rule(">[%w%s]*$", "^%s*</", { "eruby", }):only_cr():use_regex(true),

      -- Inserts #{} inside ruby strings for interpolation
      -- TODO: Don't do this if it's the first character in the string and the method is "describe"
      rule("#", "{}", "ruby")
      :with_pair(ts_conds.is_ts_node({ 'string' }))
      :set_end_pair_length(1),

      rule("|", "|", "ruby")
      :with_pair(function() return true end)
      :with_move(function(opts) return opts.prev_char:match("|") ~= nil end)
      :use_key("|"),

      -- Adding space inside brackets
      rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
      end),

      rule("( ", " )")
      :with_pair(function() return false end)
      :with_move(function(opts) return opts.prev_char:match(".%)") ~= nil end)
      :use_key(")"),

      rule("{ ", " }")
      :with_pair(function() return false end)
      :with_move(function(opts) return opts.prev_char:match(".%}") ~= nil end)
      :use_key("}"),

      rule("[ ", " ]")
      :with_pair(function() return false end)
      :with_move(function(opts) return opts.prev_char:match(".%]") ~= nil end)
      :use_key("]"),

      -- 'move through' commas
      rule("", ",")
      :with_move(function(opts) return opts.char == "," end)
      :with_pair(function() return false end)
      :with_del(function() return false end)
      :with_cr(function() return false end)
      :use_key(","),
    })
  end
}
