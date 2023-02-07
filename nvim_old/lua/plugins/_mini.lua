local M = {}

M.config = function()
  require("mini.jump").setup({
    mappings = {
      forward = "f",
      backward = "F",
      forward_till = "t",
      backward_till = "T",
      repeat_jump = "",
    },
  })

  require("mini.ai").setup({})

  local align = require("mini.align")
  align.setup({
    modifiers = {
      ['{'] = function(steps, opts)
        opts.split_pattern = '{'
        opts.merge_delimiter = ' '
        table.insert(steps.pre_justify, align.gen_step.trim())
      end
    }
  })

  require("mini.indentscope").setup({
    draw = {
      animation = require("mini.indentscope").gen_animation.exponentialOut,
    },
    symbol = "│",
  })

  require("mini.surround").setup({
    search_method = "cover_or_next",
    highlight_duration = 2000,
    mappings = {
      add = "ys",
      delete = "ds",
      replace = "cs",
      highlight = "",
      find = "",
      find_left = "",
      update_n_lines = "",
    },
    custom_surroundings = {
      ["("] = { output = { left = "( ", right = " )" } },
      ["["] = { output = { left = "[ ", right = " ]" } },
      ["{"] = { output = { left = "{ ", right = " }" } },
      ["<"] = { output = { left = "< ", right = " >" } },
      ["|"] = { output = { left = "|", right = "|" } },
      ["%"] = { output = { left = "<% ", right = " %>" } },
    },
  })

  require("mini.comment").setup({
    hooks = {
      pre = require("ts_context_commentstring.internal").update_commentstring,
    },
  })

  require("mini.bufremove").setup({})
end

return M
