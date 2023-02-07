return {
  {
    "echasnovski/mini.indentscope",
    event = "BufReadPre",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "neo-tree", "lazy", "NeogitStatus", "neotest-summary" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      local indentscope = require("mini.indentscope")
      indentscope.setup({
        draw = {
          animation = indentscope.gen_animation.exponentialOut,
        },
        symbol = vim.g.indent_blankline_char,
      })
    end,
  },
  {
    "echasnovski/mini.jump",
    event = "BufReadPre",
    opts = {
      mappings = {
        forward       = "f",
        backward      = "F",
        forward_till  = "t",
        backward_till = "T",
        repeat_jump   = "",
      },
    },
    config = function(_, opts)
      require("mini.jump").setup(opts)
    end,
  },
  {
    "echasnovski/mini.ai",
    event = "BufReadPre",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    init = function()
      -- no need to load the plugin, since we only need its queries
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
    end,
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        custom_textobjects = {
          b = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer", "@function.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner", "@function.inner" },
          }, {}),
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner"
          }, {}),
        },
      })
    end
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
    end
  },
  {
    "echasnovski/mini.surround",
    event = "BufReadPre",
    opts = {
      search_method = "cover_or_next",
      highlight_duration = 2000,
      mappings = {
        add            = "ys",
        delete         = "ds",
        replace        = "cs",
        highlight      = "",
        find           = "",
        find_left      = "",
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
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
  {
    "echasnovski/mini.comment",
    event = "BufReadPre",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("mini.comment").setup(
        { hooks = { pre = require("ts_context_commentstring.internal").update_commentstring, }, }
      )
    end
  },
  {
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup({
        mappings = {
          right      = "", -- noop
          left       = "", -- noop
          line_left  = "", -- noop
          line_right = "", -- noop
        }
      })
    end,
  },
  {
    "echasnovski/mini.bufremove",
    config = function()
      require("mini.bufremove").setup({})
    end,
  }
}
