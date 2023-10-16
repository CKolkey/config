local mappings = {
  insert = {
    -- Insert undo-breakpoints
    [","] = ",<c-g>u",
    ["."] = ".<c-g>u",

    -- Readline Style Bindings
    ["<C-e>"] = "<end>",
    ["<C-a>"] = "<home>",

    -- Remove Arrow Keys
    ["<Up>"] = "<Nop>",
    ["<Down>"] = "<Nop>",
  },
  normal = {
    ["<esc>"] = "<esc>:lua require('notify').dismiss()<CR>",

    -- Buffer/Window Movements
    ["<C-h>"] = Kitty.navigate.left,
    ["<C-j>"] = Kitty.navigate.bottom,
    ["<C-k>"] = Kitty.navigate.top,
    ["<C-l>"] = Kitty.navigate.right,

    -- Toggle Folds
    ["<tab>"] = "za",

    ["<leader>bb"] = { require("utils.functions").debugger, { expr = true } },

    -- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
    -- Change current word (dot repeatable)
    ["cn"] = "*``cgn",
    ["cN"] = "*``cgN",

    -- Paste should match indentation
    ["p"] = "p=`]",

    -- Don't yank empty lines into the main register
    ["dd"] = { require("utils.functions").smart_delete, { expr = true } },

    -- Quickfix Navigation
    ["<left>"] = require("utils.functions").load_quickfix,

    -- Retain cursor position when joining lines, and remove spaces from method chains
    ["J"] = require("utils.functions").smart_join,

    -- Close split using c-q, close pane keeping split with c-w
    ["<C-q>"] = ":cclose<cr>:bd<cr>",
    ["<C-w>"] = { utils.delete_buf, { nowait = true } },
    ["<C-e>"] = "<C-w>c<cr>",

    -- -- buffer splits
    -- ["<leader>sh"] = { ":leftabove  vnew<CR>:bprev<CR>", { nowait = true } },
    -- ["<leader>sj"] = { ":rightbelow new<CR>:bprev<CR>", { nowait = true } },
    -- ["<leader>sk"] = { ":leftabove  new<CR>:bprev<CR>", { nowait = true } },
    -- ["<leader>sl"] = { ":rightbelow vnew<CR>:bprev<CR>", { nowait = true } },

    -- Enter inserts newline without leaving Normal mode
    ["<cr>"] = "o<Esc>",

    [";"] = { ":", { silent = false, nowait = true } },

    -- Forward/backward on Changelist
    ["<m-i>"] = "g,",
    ["<m-o>"] = "g;",

    -- rebind 'i' to do a smart-indent if its a blank line
    ["i"] = { require("utils.functions").smart_insert, { expr = true } },

    -- vv selects the whole line
    ["vv"] = "V",

    -- V selects until the end of the line
    ["V"] = "v$",

    -- More sane vertical navigation
    ["k"] = "gk",
    ["j"] = "gj",

    -- Format File
    ["<leader><leader>"] = require("utils.functions").format,

    -- Fast Find and Replace, fallback since LSP might override 'R'
    ["<leader>r"] = {
      "mz:%s/\\<<C-r><C-w>\\>//g | silent update | normal! `z<S-Left><S-Left><S-Left><S-Left><S-Left><S-Left><Left><Left><Left><C-r><C-w>",
      { silent = false },
    },

    -- Open Last Buffer
    ["<bs>"] = "<C-^>",

    -- Play Last Macro with Q
    ["Q"] = "@@",

    -- Fast movement to start/end of line
    ["H"] = "^",
    ["L"] = "g_",

    -- jump list next ('<f13>' is what c-i sends, thanks to Karabiner. This addresses collision with Tab)
    ["<F13>"] = "<c-i>",
  },
  terminal = {
    -- Terminal window navigation
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",

    -- Readline Style Bindings
    ["<C-e>"] = "<end>",
    ["<C-a>"] = "<home>",

    -- You are probably looking at the wrong buffer
    ["jj"] = { "<c-k>", { remap = true } },
    ["kk"] = { "<c-k>", { remap = true } },
  },
  visual = {
    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",

    -- More sane vertical navigation
    ["k"] = "gk",
    ["j"] = "gj",

    -- Fast movement to start/end of line
    ["H"] = "^",
    ["L"] = "g_",

    -- Restore cursor position after yank
    ["y"] = "may`a",

    ["R"] = {
      ":s/\\<\\>//g | silent update<S-Left><S-Left><S-Left><Left><Left><Left><Left><Left><Left>",
      { silent = false },
    },
  },
  visual_block = {
    ["s"] = require("substitute").visual,
  },
  command = {
    -- Feeds absolute filepath of current buffer into cmd
    ["%%"] = { require("utils.functions").feed_current_dir, { expr = true } },

    -- -- Basic autocomplete
    -- ["("] = { "()<left>", { silent = false } },
    -- ["["] = { "[]<left>", { silent = false } },
    -- ['"'] = { [[""<left>]], { silent = false } },
    -- ["'"] = { [[''<left>]], { silent = false } },
  },
  operator_pending = {
    -- Fast movement to start/end of line
    ["H"] = "^",
    ["L"] = "g_",
  },
  select = {},
  replace = {},
}

require("utils.keymaps").load(mappings)
