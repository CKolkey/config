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
    -- Buffer/Window Movements
    ["<C-h>"]            = Kitty.navigate.left,
    ["<C-j>"]            = Kitty.navigate.bottom,
    ["<C-k>"]            = Kitty.navigate.top,
    ["<C-l>"]            = Kitty.navigate.right,

    -- Move windows around
    ["<C-M-left>"]       = "<cmd>WinShift left<CR>",
    ["<C-M-up>"]         = "<cmd>WinShift up<CR>",
    ["<C-M-right>"]      = "<cmd>WinShift right<CR>",
    ["<C-M-down>"]       = "<cmd>WinShift down<CR>",

    -- Resize Splits
    ["<C-left>"]         = require('smart-splits').resize_left,
    ["<C-up>"]           = require('smart-splits').resize_up,
    ["<C-right>"]        = require('smart-splits').resize_right,
    ["<C-down>"]         = require('smart-splits').resize_down,

    ["<leader>ha"]       = require("harpoon.mark").add_file,
    ["<leader>hh"]       = require("harpoon.ui").toggle_quick_menu,
    ["<leader>h1"]       = function() require("harpoon.ui").nav_file(1) end,
    ["<leader>h2"]       = function() require("harpoon.ui").nav_file(2) end,
    ["<leader>h3"]       = function() require("harpoon.ui").nav_file(3) end,
    ["<leader>h4"]       = function() require("harpoon.ui").nav_file(4) end,
    ["<leader>h5"]       = function() require("harpoon.ui").nav_file(5) end,
    ["<leader>h6"]       = function() require("harpoon.ui").nav_file(6) end,
    ["<leader>h7"]       = function() require("harpoon.ui").nav_file(7) end,
    ["<leader>h8"]       = function() require("harpoon.ui").nav_file(8) end,
    ["<leader>h9"]       = function() require("harpoon.ui").nav_file(9) end,
    ["<leader>h0"]       = function() require("harpoon.ui").nav_file(10) end,

    ["K"]                = require("ts-node-action").node_action,

    -- Toggle Folds
    ["<tab>"]            = "za",

    ["<leader>bb"]       = { require("utils.functions").debugger, { expr = true } },

    -- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
    -- Change current word (dot repeatable)
    ["cn"]               = "*``cgn",
    ["cN"]               = "*``cgN",

    -- Swap with  ts_node of same parent
    ["<m-.>"]            = "<cmd>SwapNext<cr>",
    ["<m-,>"]            = "<cmd>SwapPrev<cr>",

    -- Git
    ["<leader>gg"]       = ":Neogit<cr>",
    ["<leader>gh"]       = ":DiffviewFileHistory %<cr>",
    ["<leader>gd"]       = ":DiffviewOpen<cr>",
    ["<leader>gw"]       = ":Gitsigns toggle_word_diff<cr>",
    ["<leader>gb"]       = ":Gitsigns toggle_current_line_blame<cr>",
    ["<leader>gA"]       = function()
      vim.cmd([[Gitsigns stage_buffer]])
      vim.notify("*Staged:* `" .. vim.fn.expand("%:.") .. "`", vim.log.levels.INFO, { icon = Icons.git.added })
    end,
    ["<leader>ga"]       = function()
      vim.cmd([[Gitsigns stage_hunk]])
      vim.notify("*Staged:* `" .. vim.fn.expand("%:.") .. "`", vim.log.levels.INFO, { icon = Icons.git.added })
    end,

    -- Don't yank empty lines into the main register
    ["dd"]               = {
      function()
        if vim.api.nvim_get_current_line():match("^%s*$") then
          return '"_dd'
        else
          return "dd"
        end
      end, { expr = true }
    },

    -- Quickfix Navigation
    ["<Up>"]             = ":QPrev<cr>",
    ["<Down>"]           = ":QNext<cr>",
    ["<Right>"]          = ":QFToggle!<cr>",
    ["<left>"]           = function()
      if utils.file_in_cwd("tmp/quickfix.out") then
        vim.cmd("silent cf tmp/quickfix.out")
        vim.cmd("QFToggle!")
        vim.notify("Loaded Quickfix", vim.log.levels.INFO)
      else
        vim.notify("No quickfix file", vim.log.levels.WARN)
      end
    end,

    -- Retain cursor position when joining lines, and remove spaces from method chains
    ["J"]                = function()
      vim.cmd("normal! mzJ")

      local col     = vim.fn.col(".")
      local context = string.sub(vim.fn.getline("."), col - 1, col + 1)
      if context == ") ." or context == ") :" or context:match("%( .") or context:match(". ,") or context:match("%w %.") then
        vim.cmd("undojoin | normal! x")
      elseif context == ",)" then
        vim.cmd("undojoin | normal! hx")
      end

      vim.cmd("normal! `z")
    end,

    -- Close split using c-q, close pane keeping split with c-w
    ["<C-q>"]            = ":cclose<cr>:bd<cr>",
    ["<C-w>"]            = { utils.delete_buf, { nowait = true } },
    ["<C-e>"]            = "<C-w>c<cr>",

    -- Cycle buffers
    ["<m-h>"]            = ":BufferLineCycleWindowlessPrev<cr>",
    ["<m-l>"]            = ":BufferLineCycleWindowlessNext<cr>",

    -- buffer splits
    ["<leader>sh"]       = { ":leftabove  vnew<CR>:bprev<CR>", { nowait = true } },
    ["<leader>sl"]       = { ":rightbelow vnew<CR>:bprev<CR>", { nowait = true } },
    ["<leader>sk"]       = { ":leftabove  new<CR>:bprev<CR>", { nowait = true } },
    ["<leader>sj"]       = { ":rightbelow new<CR>:bprev<CR>", { nowait = true } },

    -- Enter inserts newline without leaving Normal mode
    ["<cr>"]             = "o<Esc>",

    -- rebinds semi-colon in normal mode.
    [";"]                = { ":", { silent = false, nowait = true } },

    -- Forward/backward on Changelist
    ["<m-i>"]            = "g,",
    ["<m-o>"]            = "g;",

    -- rebind 'i' to do a smart-indent if its a blank line
    ["i"]                = {
      function()
        if #vim.fn.getline(".") == 0 then
          return [["_cc]]
        else
          return "i"
        end
      end,
      { expr = true }
    },

    -- vv selects the whole line
    ["vv"]               = "V",

    -- V selects until the end of the line
    ["V"]                = "v$",

    -- More sane vertical navigation
    ["k"]                = "gk",
    ["j"]                = "gj",

    -- Format File
    ["<leader><leader>"] = require("utils.functions").format,

    -- Leap
    ["<space>"]          = ":LeapOmni<cr>",

    -- Fast Find and Replace, fallback since LSP might override 'R'
    ["<leader>r"]        = {
      "mz:%s/\\<<C-r><C-w>\\>//g | silent update | normal! `z<S-Left><S-Left><S-Left><S-Left><S-Left><S-Left><Left><Left><Left><C-r><C-w>",
      { silent = false },
    },

    -- Open Last Buffer
    ["<bs>"]             = "<C-^>",

    -- Play Last Macro with Q
    ["Q"]                = "@@",

    -- For debugging ColorSchemes
    ["<F10>"]            = "<cmd>Inspect!<cr>",

    -- Fast movement to start/end of line
    ["H"]                = "^",
    ["L"]                = "g_",

    -- jump list next ('<f13>' is what c-i sends, thanks to Karabiner. This addresses collision with Tab)
    ["<F13>"]            = "<c-i>",

    -- Telescope
    -- https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
    ["<c-g>"]            = function()
      require("telescope").extensions.live_grep_args.live_grep_args({ debounce = 100 })
      -- Insert Quotes
      local keys = vim.api.nvim_replace_termcodes([[""<left>]], true, false, true)
      vim.api.nvim_feedkeys(keys, 'c', false)
    end,

    ["<leader>g"]        = require("telescope.builtin").current_buffer_fuzzy_find,

    -- <A-c>  = create
    -- <S-CR> = create_from_prompt
    -- <A-r>  = rename
    -- <A-m>  = move
    -- <A-y>  = copy
    -- <A-d>  = remove
    --
    -- <C-o>  = open
    -- <C-g>  = goto_parent_dir
    -- <C-e>  = goto_home_dir
    -- <C-w>  = goto_cwd
    -- <C-t>  = change_cwd
    -- <C-f>  = toggle_browser
    -- <C-h>  = toggle_hidden
    -- <C-s>  = toggle_all
    ["-"]                = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
    ["_"]                = "<cmd>Neotree filesystem toggle<cr>",

    ["z="]               = function()
      require("telescope.builtin").spell_suggest(require('telescope.themes').get_cursor({
        borderchars = {
          prompt  = { " ", " ", " ", " ", " ", " ", " ", " " },
          results = { " ", " ", " ", " ", " ", " ", " ", " " },
          preview = { "", "", "", "▌", "▌", "", "", "▌" },
        },
      }))
    end,

    -- Live grep, starting with cursor word
    ["<c-space>"]        = function()
      local word = vim.fn.expand("<cword>")
      require("telescope").extensions.live_grep_args.live_grep_args({ debounce = 100 })
      local keys = vim.api.nvim_replace_termcodes([[""<left>]] .. word, true, false, true)
      vim.api.nvim_feedkeys(keys, 'c', false)
    end,
    -- ["<c-f>"]            = function() require('telescope').extensions.smart_open.smart_open({ cwd_only = true }) end,
    ["<c-f>"]            = require("telescope.builtin").find_files,
    ["<c-b>"]            = require("telescope.builtin").buffers,
    ["<c-z>"]            = require("telescope.builtin").help_tags,
    ["<m-r>"]            = "<cmd>Telescope resume<cr>",

    -- Substitute
    ["s"]                = require("substitute").operator,
    ["S"]                = require("substitute").eol,
    ["ss"]               = require("substitute").line,

    ["<leader>m"]        = function()
      local cmd = "bundle exec rspec " .. vim.fn.expand("%:.") .. ":" .. vim.fn.line(".") ..
          " --format failures --out tmp/quickfix.out --format Fuubar"

      require("toggleterm").exec_command("cmd='" .. cmd .. "'")
    end,

    ["<leader>M"]        = function()
      local cmd = "bundle exec rspec " ..
          vim.fn.expand("%:.") .. " --format failures --out tmp/quickfix.out --format Fuubar"
      require("toggleterm").exec_command("cmd='" .. cmd .. "'")
    end,

    ["<leader>ts"]       = ":ToggleTermSendVisualSelection<CR>",
    ["<leader>tl"]       = ":ToggleTermSendCurrentLine<CR>",
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
    ["%%"] = {
      function()
        vim.api.nvim_feedkeys(vim.fn.expand('%:p:h') .. '/', 'c', false)
      end,
      { expr = true },
    },

    -- Basic autocomplete
    ["("] = { "()<left>", { silent = false } },
    ["["] = { "[]<left>", { silent = false } },
    ['"'] = { [[""<left>]], { silent = false } },
    ["'"] = { [[''<left>]], { silent = false } },
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
