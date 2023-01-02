local definitions = {
  config_reloading = {
    {
      event = "BufWritePost",
      pattern = "*/nvim/lua/after/snippets/*.lua",
      callback = {
        function()
          local filetype = vim.fn.expand("<afile>"):match("^.*/(.*).lua$")
          utils.plugin("luasnip").load_snippets(filetype)
          print("Reloading Snippets: " .. filetype)
        end,
      },
    },
  },

  treesitter_install = {
    desc = "Lazily installs treesitter parsers",
    {
      event = "FileType",
      callback = function()
        local parsers = require("nvim-treesitter.parsers")
        local lang = parsers.get_buf_lang()
        if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
          vim.schedule_wrap(function()
            vim.cmd("TSInstallSync " .. lang)
          end)()
        end
      end,
    },
  },

  load_snippets = {
    desc = "Load snippets for filetype",
    { event = "BufEnter", command = "LuasnipAutoloadFilteypeSnippets" },
  },

  format_file = {
    desc = "Formatting File after write",
    { event = "BufWritePost", callback = require("utils.functions").format },
  },

  autoreload = {
    desc = "Automatically reloads buffer if it's changed externally",
    { event = { "FocusGained", "BufEnter", "CursorHold" }, command = "silent! checktime %" },
  },

  line_number_toggle = {
    desc = "Toggles Relative/Absolute Line Numbering for Ins/Norm Modes",
    { event = "InsertLeave", command = "setlocal relativenumber" },
    { event = "InsertEnter", command = "setlocal norelativenumber" },
  },

  terminal_behavior = {
    desc = "Sets some nice defaults for a Terminal Buffer",
    { event = "WinEnter", pattern = "term://*", command = { "startinsert" } },
  },

  highlight_yank = {
    desc = "Visually highlight yanked area",
    {
      event = "TextYankPost",
      callback = function()
        vim.highlight.on_yank({ higroup = "VisualYank", timeout = 800, on_visual = true })
      end,
    },
  },

  auto_resize = {
    desc = "Resizes buffers when screen area is resized",
    { event = "VimResized", command = "tabdo wincmd =" },
  },

  mkdir_on_save = {
    desc = "Auto-Create any missing folders when writing a file",
    { event = "BufWritePre", command = "call mkdir(expand('<afile>:p:h'), 'p')" },
  },

  cursor_position = {
    desc = "Keeps cursor position when leaving insert mode, and reloads last position when opening buffer",
    { event = "InsertLeave", command = "normal `^" },
    -- {
    --   event = "BufReadPost",
    --   command = [[if line("'\"") > 0 && line("'\"") <= line("$") && &ft != "help" | exe "normal g`\"zz" | endif]],
    -- },
  },

}

require("utils.autocmds").load(definitions)
