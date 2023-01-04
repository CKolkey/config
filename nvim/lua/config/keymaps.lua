local mappings = {
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
    ["<C-h>"] = ":KittyNavigateWest<cr>",
    ["<C-j>"] = ":KittyNavigateSouth<cr>",
    ["<C-k>"] = ":KittyNavigateNorth<cr>",
    ["<C-l>"] = ":KittyNavigateEast<cr>",

    ["<leader>ha"] = require("harpoon.mark").add_file,
    ["<leader>hh"] = require("harpoon.ui").toggle_quick_menu,
    ["<leader>h1"] = function() require("harpoon.ui").nav_file(1) end,
    ["<leader>h2"] = function() require("harpoon.ui").nav_file(2) end,
    ["<leader>h3"] = function() require("harpoon.ui").nav_file(3) end,
    ["<leader>h4"] = function() require("harpoon.ui").nav_file(4) end,
    ["<leader>h5"] = function() require("harpoon.ui").nav_file(5) end,
    ["<leader>h6"] = function() require("harpoon.ui").nav_file(6) end,
    ["<leader>h7"] = function() require("harpoon.ui").nav_file(7) end,
    ["<leader>h8"] = function() require("harpoon.ui").nav_file(8) end,
    ["<leader>h9"] = function() require("harpoon.ui").nav_file(9) end,
    ["<leader>h0"] = function() require("harpoon.ui").nav_file(10) end,

    ["K"] = require("ts-node-action").node_action,

    ["<leader>bb"] = { require("utils.functions").debugger, { expr = true } },

    -- print from register on newline
    -- ["P"] = "o<esc>p==^",

    -- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
    -- Change current word (dot repeatable)
    ["cn"] = "*``cgn",
    ["cN"] = "*``cgN",

    -- Git
    ["<leader>gg"] = ":Neogit kind=vsplit<cr>",

    ["<leader>gA"] = function() -- Add all files in CWD
      vim.cmd([[silent exe '!git add . -f']])
      vim.notify("*Staged:* `" .. vim.fn.fnamemodify(".", ":~") .. "/`", vim.log.levels.INFO, { icon = Icons.git.added })
    end,

    ["<leader>ga"] = function() -- Add current file
      vim.cmd([[silent exe '!git add % -f']])
      vim.notify("*Staged:* `" .. vim.fn.expand("%:.") .. "`", vim.log.levels.INFO, { icon = Icons.git.added })
    end,

    ["<leader>gb"] = ":Gitsigns toggle_current_line_blame<cr>",

    -- Don't yank empty lines into the main register
    ["dd"] = {
      function()
        if vim.api.nvim_get_current_line():match("^%s*$") then
          return '"_dd'
        else
          return "dd"
        end
      end, { expr = true }
    },

    -- Quickfix Navigation
    ["<Up>"] = ":QPrev<cr>",
    ["<Down>"] = ":QNext<cr>",
    ["<Right>"] = ":QFToggle!<cr>",
    ["<left>"] = ":silent cf tmp/quickfix.out<CR>:QFToggle!<cr>",

    -- Move current line / block with Alt-j/k a la vscode.
    ["<m-k>"] = ":move .-2<CR>==",
    ["<m-j>"] = ":move .+1<CR>==",

    -- Dont lose position when joining lines
    ["J"] = "mzJ`z",

    -- Close split using c-q, close pane keeping split with c-w
    ["<C-q>"] = ":call SmartCloseTerminal()<cr>:cclose<cr>:bd<cr>",
    ["<C-w>"] = { utils.delete_buf, { nowait = true } },
    ["<C-e>"] = "<C-w>c<cr>",

    -- Cycle buffers
    ["<m-h>"] = ":BufferLineCyclePrev<cr>",
    ["<m-l>"] = ":BufferLineCycleNext<cr>",

    -- buffer splits
    ["<leader>sh"] = { ":leftabove  vnew<CR>:bprev<CR>", { nowait = true } },
    ["<leader>sl"] = { ":rightbelow vnew<CR>:bprev<CR>", { nowait = true } },
    ["<leader>sk"] = { ":leftabove  new<CR>:bprev<CR>", { nowait = true } },
    ["<leader>sj"] = { ":rightbelow new<CR>:bprev<CR>", { nowait = true } },

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
    ["i"] = {
      function()
        if #vim.fn.getline(".") == 0 then
          return [["_cc]]
        else
          return "i"
        end
      end,
      { expr = true }
    },

    -- No-op ex mode
    ["q:"] = "",

    -- vv selects the whole line
    ["vv"] = "V",

    -- V selects until the end of the line
    ["V"] = "v$",

    -- More sane vertical navigation
    ["k"] = "gk",
    ["j"] = "gj",

    -- Edit filetype file
    ["<leader>ft"] = ":EditFtFile<cr>",

    -- Format File
    ["<leader><leader>"] = require("utils.functions").format,

    -- Leap
    ["<space>"] = ":LeapOmni<cr>",

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

  command = {
    ["%%"] = {
      function()
        vim.api.nvim_feedkeys(vim.fn.expand('%:p:h') .. '/', 'c', false)
      end,
      { expr = true },
    },
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
