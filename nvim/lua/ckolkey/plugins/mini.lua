return {
  {
    "echasnovski/mini.indentscope",
    event = "BufReadPre",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "lazy", "NeogitStatus" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      local indentscope = require("mini.indentscope")
      indentscope.setup({
        draw = {
          animation = indentscope.gen_animation.exponentialOut,
        },
        symbol = Icons.misc.v_pipe,
        mappings = {
          -- object_scope = "ii",
          -- object_scope_with_border = "ai",
          goto_top = "[i",
          goto_bottom = "]i",
        },
      })
    end,
  },
  { "echasnovski/mini.extra" },
  {
    "echasnovski/mini.ai",
    event = "BufReadPre",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    init = function()
      -- no need to load the plugin, since we only need its queries
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
    end,
    config = function()
      local extra = require("mini.extra")
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          b = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
          d = { "%f[%d]%d+" },                                                          -- digits
          e = {                                                                         -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          i = extra.gen_ai_spec.indent(),
          g = extra.gen_ai_spec.buffer(),
          u = ai.gen_spec.function_call(),                           -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }, {}),
        },
      })
    end,
  },
  {
    "echasnovski/mini.align",
    event = "BufReadPre",
    config = function()
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
    end,
  },
  {
    "echasnovski/mini.surround",
    event = "BufReadPre",
    opts = {
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
        ["("] = { output = { left = "(", right = ")" } },
        ["["] = { output = { left = "[", right = "]" } },
        ["{"] = { output = { left = "{ ", right = " }" } },
        ["<"] = { output = { left = "<", right = ">" } },
        [">"] = { output = { left = "<", right = ">" } },
        ["|"] = { output = { left = "|", right = "|" } },
        ["%"] = { output = { left = "<% ", right = " %>" } },
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = "BufReadPre",
    opts = {},
  },
  {
    "echasnovski/mini.bufremove",
    opts = {},
  },
  {
    "echasnovski/mini.bracketed",
    opts = {},
  },
  {
    "echasnovski/mini.hipatterns",
    opts = {
      highlighters = {
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "HighlightCommentFixme" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "HighlightCommentTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "HighlightCommentNote" },
      },
    }
  },
  {
    "echasnovski/mini.operators",
    version = "*",
    config = function()
      local config = {
        evaluate = { prefix = 'g=', },
        exchange = { prefix = 'ge', },
        multiply = { prefix = 'gm', },
        sort     = { prefix = 'gs', },
        replace  = { prefix = '', },
      }

      local operators = require('mini.operators')
      operators.setup(config)

      -- operators.make_mappings(
      --   'replace',
      --   { textobject = 's', line = 'ss', selection = 's' }
      -- )
    end
  }
}
