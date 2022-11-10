local M = {}

M.mappings = {
  insert = {
    -- Insert undo-breakpoints
    [","] = ",<c-g>u",
    ["."] = ".<c-g>u",

    -- Readline Style Bindings
    ["<C-e>"] = "<end>",
    ["<C-a>"] = "<home>",
    ["<C-f>"] = "<c-right>",
    ["<C-b>"] = "<c-left>",

    -- Remove Arrow Keys
    ["<Up>"] = "<Nop>",
    ["<Down>"] = "<Nop>",

    -- Move lines up/down
    ["<a-k>"] = "<esc>:m .-2<cr>==gi",
    ["<a-j>"] = "<esc>:m .+1<cr>==gi",
  },

  normal = {
    -- Buffer/Window Movements
    ["<C-h>"] = utils.plugin("kitty").navigate_left,
    ["<C-j>"] = utils.plugin("kitty").navigate_down,
    ["<C-k>"] = utils.plugin("kitty").navigate_up,
    ["<C-l>"] = utils.plugin("kitty").navigate_right,

    ["<leader>ha"] = require("harpoon.mark").add_file,
    ["<leader>hh"] = require("harpoon.ui").toggle_quick_menu,
    ["<leader>h1"] = utils.plugin("harpoon_config").goto_file_1,
    ["<leader>h2"] = utils.plugin("harpoon_config").goto_file_2,
    ["<leader>h3"] = utils.plugin("harpoon_config").goto_file_3,
    ["<leader>h4"] = utils.plugin("harpoon_config").goto_file_4,
    ["<leader>h5"] = utils.plugin("harpoon_config").goto_file_5,
    ["<leader>h6"] = utils.plugin("harpoon_config").goto_file_6,
    ["<leader>h7"] = utils.plugin("harpoon_config").goto_file_7,
    ["<leader>h8"] = utils.plugin("harpoon_config").goto_file_8,
    ["<leader>h9"] = utils.plugin("harpoon_config").goto_file_9,
    ["<leader>h0"] = utils.plugin("harpoon_config").goto_file_10,

    [","] = utils.plugin("treesitter").node_action,

    -- Open cmd with same path as current file already printed
    ["<leader>e"] = [[:e <C-R>=expand("%:p:h") . "/" <CR>]],

    -- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
    -- Change current word (dot repeatable)
    ["cn"] = "*``cgn",
    ["cN"] = "*``cgN",

    -- Git
    ["<leader>gg"] = require("neogit").open,
    ["<leader>gA"] = function() -- Add all files in CWD
      vim.cmd([[silent exe '!git add . -f']])
      vim.notify("Staged: " .. vim.fn.fnamemodify(".", ":~") .. "/", "info", { title = "Git" })
    end,
    ["<leader>ga"] = function() -- Add current file
      vim.cmd([[silent exe '!git add % -f']])
      vim.notify("Staged: " .. vim.fn.expand("%:."), "info", { title = "Git" })
    end,
    ["<leader>gh"] = "<cmd>DiffviewFileHistory %<cr>",
    ["<leader>gd"] = "<Cmd>DiffviewOpen<CR>",
    ["<leader>gb"] = "<cmd>Gitsigns toggle_current_line_blame<cr>",

    ["dd"] = { require("functions").smart_dd, { expr = true } },

    -- Quickfix Navigation
    ["<Up>"] = ":QPrev<cr>",
    ["<Down>"] = ":QNext<cr>",
    ["<Right>"] = ":QFToggle!<cr>",
    ["<left>"] = ":silent cf tmp/quickfix.out<CR>:QFToggle!<cr>",

    -- Move current line / block with Alt-j/k a la vscode.
    ["<m-k>"] = ":move .-2<CR>==",
    ["<m-j>"] = ":move .+1<CR>==",

    -- Indent/Dedent
    -- ["<Tab>"] = ">>",
    -- ["<S-Tab>"] = "<<",

    -- Dont lose position when joining lines
    ["J"] = "mzJ`z",
    ["K"] = require("trevj").format_at_cursor,

    -- Close split using c-q, close pane keeping split with c-w
    ["<C-q>"] = ":call SmartCloseTerminal()<cr>:cclose<cr>:bd<Cr>",
    ["<C-w>"] = { utils.delete_buf, { nowait = true } },
    ["<C-e>"] = "<C-w>c<cr>",

    -- Cycle buffers
    ["<m-h>"] = ":BufferLineCyclePrev<cr>",
    ["<m-l>"] = ":BufferLineCycleNext<cr>",

    -- buffer splits
    -- ["<leader>sh"] = { ":leftabove  vnew<CR>:bprev<CR>", { nowait = true } },
    -- ["<leader>sl"] = { ":rightbelow vnew<CR>:bprev<CR>", { nowait = true } },
    -- ["<leader>sk"] = { ":leftabove  new<CR>:bprev<CR>", { nowait = true } },
    -- ["<leader>sj"] = { ":rightbelow new<CR>:bprev<CR>", { nowait = true } },

    ["-"] = "<cmd>Neotree filesystem toggle<cr>",

    -- Enter inserts newline without leaving Normal mode
    ["<cr>"] = "o<Esc>",

    -- Center Search Results
    ["n"] = "nzzzv",
    ["N"] = "Nzzzv",
    ["*"] = "*zzzv",
    ["#"] = "#zzzv",
    ["{"] = "{k^zzzv",
    ["}"] = "}j^zzzv",

    -- rebinds semi-colon in normal mode.
    [";"] = { ":", { silent = false, nowait = true } },

    -- rebind 'i' to do a smart-indent if its a blank line
    ["i"] = { "SmartInsert()", { expr = true } },

    -- vv selects the whole line
    ["vv"] = "V",

    -- V selects until the end of the line
    ["V"] = "v$",

    -- More sane vertical navigation
    ["k"] = "gk",
    ["j"] = "gj",

    -- Edit filetype file
    ["<leader>ft"] = ":call EditFtFile()<cr>",

    -- Format File
    ["<leader><leader>"] = require("functions").format,

    -- Leap
    ["<space>"] = utils.plugin("leap").omni,

    -- Fast Find and Replace, fallback since LSP might override 'R'
    ["R"] = {
      ":%s/\\<<C-r><C-w>\\>//g | silent update<S-Left><S-Left><S-Left><Left><Left><Left>",
      { silent = false },
    },
    ["<leader>R"] = {
      ":%s/\\<<C-r><C-w>\\>//g | silent update<S-Left><S-Left><S-Left><Left><Left><Left><C-r><C-w>",
      { silent = false },
    },

    -- Open Last Buffer
    ["<bs>"] = "<C-^>",

    -- Play Last Macro with Q
    ["Q"] = "@@",

    -- For debugging ColorSchemes
    ["<F10>"] = ":TSHighlightCapturesUnderCursor<cr>",

    -- Fast movement to start/end of line
    ["H"] = "^",
    ["L"] = "g_",

    -- Toggle Terminal
    ["``"] = ":call ToggleTerminalDrawer()<cr>",

    -- jump list next ('<f13>' is what c-i sends, thanks to Karabiner. This addresses collision with Tab)
    ["<F13>"] = "<c-i>",

    -- Telescope
    ["<c-g>"] = require("telescope.builtin").live_grep,
    ["<c-f>"] = require("telescope.builtin").find_files,
    ["<c-b>"] = require("telescope.builtin").buffers,
    ["<c-z>"] = require("telescope.builtin").help_tags,
    ["<c-space>"] = require("telescope.builtin").grep_string,

    -- Substitute
    ["s"] = require("substitute").operator,
    ["S"] = require("substitute").eol,
    ["ss"] = require("substitute").line,

    -- test Runner
    ["<leader>m"] = function()
      require("neotest").run.run({
        extra_args = "--require=support/formatters/quickfix_formatter.rb --format QuickfixFormatter --out tmp/quickfix.out",
      })
      require("neotest").summary.open()
    end,
    ["<leader>M"] = function()
      require("neotest").run.run({
        vim.fn.expand("%"),
        extra_args = "--require=support/formatters/quickfix_formatter.rb --format QuickfixFormatter --out tmp/quickfix.out",
      })
      require("neotest").summary.open()
    end,

    ["<leader>ps"] = function()
      require("plenary.async").run(function()
        vim.notify.async("Syncing Packer.", "info", { title = "Packer" })
      end)

      vim.cmd("PackerSnapshot " .. os.date("!%Y-%m-%dT%TZ"))
      vim.cmd("PackerSync")
    end,
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

    -- Toggle Terminal
    ["``"] = "<C-\\><C-n>:call ToggleTerminalDrawer()<CR>",
  },

  visual = {
    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",

    -- Change current selection (dot repeatable)
    ["cn"] = [[vy/\V<C-R>=escape(@",'/\')<CR><CR>``cgn]],
    ["cN"] = [[vy/\V<C-R>=escape(@",'/\')<CR><CR>``cgN]],

    -- Move current line / block with Alt-j/k ala vscode.
    ["<m-k>"] = ":move '<-2<CR>gv-gv",
    ["<m-j>"] = ":move '>+1<CR>gv-gv",

    -- Paste Last Yank by default
    ["p"] = '"0p',
    ["P"] = '"0P',

    -- More sane vertical navigation
    ["k"] = "gk",
    ["j"] = "gj",

    -- Fast movement to start/end of line
    ["H"] = "^",
    ["L"] = "g_",

    ["R"] = {
      ":s/\\<\\>//g | silent update<S-Left><S-Left><S-Left><Left><Left><Left><Left><Left><Left>",
      { silent = false },
    },
  },

  visual_block = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<m-k>"] = ":move '<-2<CR>gv-gv",
    ["<m-j>"] = ":move '>+1<CR>gv-gv",

    ["s"] = require("substitute").visual,
  },

  command = {},

  operator_pending = {
    -- Fast movement to start/end of line
    ["H"] = "^",
    ["L"] = "g_",
  },

  select = {},
  replace = {},
}

local mode_sign = {
  insert = "i",
  normal = "n",
  terminal = "t",
  visual = "v",
  visual_block = "x",
  command = "c",
  operator_pending = "o",
  select = "s",
  replace = "r",
}

function M.set(mode, key, value)
  local options = {}

  if type(value) == "table" then
    options = value[2]
    value = value[1]
  end

  options = vim.tbl_extend("force", { silent = true }, options)
  vim.keymap.set(mode_sign[mode], key, value, options)
end

function M.add(keymaps)
  for mode, mappings in pairs(keymaps) do
    for key, value in pairs(mappings) do
      M.mappings[mode][key] = value
    end
  end
end

function M.load()
  for mode, mapping in pairs(M.mappings) do
    for key, value in pairs(mapping) do
      M.set(mode, key, value)
    end
  end
end

return M
