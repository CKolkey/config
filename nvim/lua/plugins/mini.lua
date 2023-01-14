local mini = {}

function mini.jump()
  require("mini.jump").setup({
    mappings = {
      forward = "f",
      backward = "F",
      forward_till = "t",
      backward_till = "T",
      repeat_jump = "",
    },
  })
end

function mini.ai()
  local ai = require("mini.ai")
  ai.setup({
    custom_textobjects = {
      b = ai.gen_spec.treesitter({
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }, {}),
      f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
      c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
    },
  })
end

function mini.align()
  local align = require("mini.align")
  align.setup({
    modifiers = {
      ["{"] = function(steps, opts)
        opts.split_pattern = "{"
        opts.merge_delimiter = " "
        table.insert(steps.pre_justify, align.gen_step.trim())
      end,
    },
  })
end

function mini.indentscope()
  local indentscope = require("mini.indentscope")
  indentscope.setup({
    draw = {
      animation = indentscope.gen_animation.exponentialOut,
    },
    symbol = vim.g.indent_blankline_char,
  })
end

function mini.surround()
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
      ["<"] = { output = { left = "<", right = ">" } },
      ["|"] = { output = { left = "|", right = "|" } },
      ["%"] = { output = { left = "<% ", right = " %>" } },
    },
  })
end

function mini.comment()
  require("mini.comment").setup({
    hooks = {
      pre = require("ts_context_commentstring.internal").update_commentstring,
    },
  })
end

function mini.bufremove()
  require("mini.bufremove").setup({})
end

return {
  "echasnovski/mini.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        -- no need to load the plugin, since we only need its queries
        require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
      end,
    },
  },
  event = "VeryLazy",
  config = function()
    mini.jump()
    mini.ai()
    mini.align()
    mini.indentscope()
    mini.surround()
    mini.comment()
    mini.bufremove()
  end,
}
