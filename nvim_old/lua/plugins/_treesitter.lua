local M = {}

local playground = {
  enable = true,
  disable = {},
  updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  persist_queries = false, -- Whether the query persists across vim sessions
  keybindings = {
    toggle_query_editor = "o",
    toggle_hl_groups = "i",
    toggle_injected_languages = "t",
    toggle_anonymous_nodes = "a",
    toggle_language_display = "I",
    focus_language = "f",
    unfocus_language = "F",
    update = "R",
    goto_node = "<cr>",
    show_help = "?",
  },
}

local autotag = {
  enable = true,
}

local refactor = {
  highlight_definitions = {
    enable = true,
    disable = { "help" },
    clear_on_cursor_move = true,
  },
  smart_rename = {
    enable = true,
    keymaps = {
      smart_rename = "grr",
    },
  },
}

local context_commentstring = {
  enable = true,
  enable_autocmd = false,
  config = {
    ruby = "# %s",
  },
}

local highlight = {
  enable = true,
  additional_vim_regex_highlighting = false,
}

local indent = {
  enable = false,
}

local matchup = {
  enable = true,
  disable = { "help" },
}

local endwise = {
  enable = true,
}

local textobjects = {
  select = {
    enable = true,
    lookahead = false,
    keymaps = {
      ["ib"] = "@block.inner",
      ["ab"] = "@block.outer",
      ["ica"] = "@call.inner",
      ["aca"] = "@call.outer",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["aco"] = "@comment.outer",
      ["iif"] = "@conditional.inner",
      ["aif"] = "@conditional.outer",
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      -- ["il"] = "@loop.inner",
      -- ["al"] = "@loop.outer",
      -- ["ipa"] = "@parameter.inner",
      -- ["apa"] = "@parameter.outer"
    },
  },

  swap = {
    enable = true,
    swap_next = { [">"] = "@swappable" },
    swap_previous = { ["<"] = "@swappable" },
  },

  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },
}

require("nvim-treesitter").define_modules({
  fold = {
    attach = function()
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldmethod = "expr"
      vim.cmd.normal("zx") -- recompute folds
    end,
    detach = function() end,
  },
})

local fold = {
  enable = true,
}

M.config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "vim", "ruby", "html" },
    playground = playground,
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
    refactor = refactor,
    autotag = autotag,
    context_commentstring = context_commentstring,
    highlight = highlight,
    indent = indent,
    matchup = matchup,
    textobjects = textobjects,
    endwise = endwise,
    fold = fold,
  })
end

return M
