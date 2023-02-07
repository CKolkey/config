local definitions = {
  config_reloading = {
    {
      event = "BufWritePost",
      pattern = "*/nvim/lua/after/snippets/*.lua",
      command = "LuasnipReloadFilteypeSnippets",
      -- TODO: Load correct filetype
      -- callback = {
      --   function()
      --     local filetype = vim.fn.expand("<afile>"):match("^.*/(.*).lua$")
      --     utils.plugin("luasnip").load_snippets(filetype)
      --     print("Reloading Snippets: " .. filetype)
      --   end,
      -- },
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
    desc = "Resizes windows when screen area is resized",
    { event = "VimResized", command = "tabdo wincmd =" },
  },

  mkdir_on_save = {
    desc = "Auto-Create any missing folders when writing a file",
    { event = "BufWritePre", command = "call mkdir(expand('<afile>:p:h'), 'p')" },
  },

  auto_update_buffer = {
    desc = "Updates the buffer, with conditions",
    {
      event = { "InsertLeave", },
      callback = require("utils.functions").update_buffer,
      nested = true
    }
  },

  buffer_changed_timestamp = {
    desc = "Adds timestamp to buffer variables. Used by autosave function to throttle.",
    {
      event = { "BufWritePost", "BufEnter" },
      callback = function(event)
        vim.api.nvim_buf_set_var(event.buf, "timestamp", vim.fn.localtime())
      end
    }
  },

  cursor_position = {
    desc = "Keeps cursor position when leaving insert mode, and reloads last position when opening buffer",
    { event = "InsertLeave", command = "normal `^" },
  },

  hide_cursorline_in_inactive_windows = {
    desc = "Only show cursorline in active buffer",
    {
      event = { "WinLeave", "WinEnter" },
      callback = function(event)
        local win_id = vim.api.nvim_get_current_win()
        vim.wo[win_id].cursorline = event.event == "WinEnter"
      end
    }
  },

  read_secrets_as_binary = {
    desc = "Reads work secrets as binary files to prevent \n at EOL",
    {
      event = { "BufEnter" },
      pattern = "*/pro-secrets/**",
      command = "setl binary noeol",
    }
  },
}

require("utils.autocmds").load(definitions)
