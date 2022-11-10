local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")

local function toggle_boolean(node)
  local start_row, start_col, end_row, end_col = node:range()
  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { tostring(node:type() ~= "true") })
end

-- TODO:
-- - space inside brackes onces collapsed should be a toggle
--
-- - indenting
--
-- - collapsing a container that contains a child node which spans multiple lines raises error:
--   {
--     data: [
--      { one: 1 }
--     ],
--     two: 2
--   }
--
-- Maybe we should recusively collapse/expand all child nodes?
--
--

local function collapse_child_nodes(node)
  local replacement = {}
  for child, _ in node:iter_children() do
    if child:named() then
      table.insert(replacement, vim.treesitter.query.get_node_text(child, 0))
    end
  end

  return { table.concat(replacement, ", ") }
end

local function expand_child_nodes(node)
  local start_row, _, _, _ = node:range()
  local replacement = {}
  local indent = require("nvim-treesitter.indent").get_indent(start_row) + 1

  for child, _ in node:iter_children() do
    if child:named() then
      -- if child:named_child_count() > 1 then
      --   expand_child_nodes(child)
      -- else
      local text = vim.treesitter.query.get_node_text(child, 0)
      -- end

      table.insert(replacement, #replacement + 1, string.rep(string.rep(" ", vim.o.shiftwidth), indent) .. text .. ",")
    end
  end

  table.insert(replacement, 1, "")
  table.insert(replacement, #replacement + 1, "")

  return replacement
end

local function toggle_multiline(node)
  local start_row, start_col, end_row, end_col = node:range()
  local view = vim.fn.winsaveview()
  local fn

  if start_row == end_row then
    fn = expand_child_nodes
  else
    fn = collapse_child_nodes
  end

  vim.api.nvim_buf_set_text(0, start_row, start_col + 1, end_row, end_col - 1, fn(node))
  vim.fn.winrestview(view)
end

local function cycle_case(node)
  local start_row, start_col, end_row, end_col = node:range()
  -- TODO: Cycle through camel, snake, kebab, pascal, title case for an identifier
  -- - Determine the current case of a node
  -- - convert that into a common format, probably something like: { 'words', 'in', 'a', 'list' }
  -- - convert that common format into the 'next' version (remember to hold onto which format you started with)
  --
  local text = vim.treesitter.query.get_node_text(node, 0)
  local words
  local format

  local formats = {
    function(tbl) -- to_snake_case
      return string.lower(table.concat(tbl, "_"))
    end,

    function(tbl) -- toCamelCase
      local tmp = vim.tbl_map(function(word)
        return word:gsub("^.", string.upper)
      end, tbl)
      local value, _ = table.concat(tmp, ""):gsub("^.", string.lower)
      return value
    end,
  }

  if string.find(text, "_") then
    -- We're in snake_case
    words = vim.split(string.lower(text), "_", { trimempty = true })
    format = 2
  else
    -- Lets presume camelCase for now
    words = vim.split(
      text:gsub(".%f[%l]", " %1"):gsub("%l%f[%u]", "%1 "):gsub("^.", string.upper),
      " ",
      { trimempty = true }
    )
    format = 1
  end

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { formats[format](words) })
end

local node_actions = {
  ["true"] = toggle_boolean,
  ["false"] = toggle_boolean,
  ["array"] = toggle_multiline,
  ["hash"] = toggle_multiline,
  ["table_constructor"] = toggle_multiline,
  ["argument_list"] = toggle_multiline,
  ["identifier"] = cycle_case,
}

-- IDEAS:
-- + Ruby: Swap hash styles between string and symbol keys

function M.node_action()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return
  end

  local action = node_actions[node:type()]
  if action then
    action(node)
  else
    print("(TS:Action) No action defined for node type: '" .. node:type() .. "'")
  end
end

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
    enable = false,
    -- swap_next = { [">"] = "@swappable" },
    -- swap_previous = { ["<"] = "@swappable" },
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

require('nvim-treesitter').define_modules {
  fold = {
    attach = function()
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldmethod = 'expr'
      vim.cmd.normal('zx') -- recompute folds
    end,
    detach = function() end,
  }
}

local fold = {
  enable = true
}

M.config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "vim", "ruby", "html" },
    playground = playground,
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = {"BufWrite", "CursorHold"},
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
