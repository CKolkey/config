local definitions = {
  config_reloading = {
    {
      event = "BufWritePost",
      pattern = "*/nvim/lua/after/snippets/*.lua",
      command = "LuasnipReloadFilteypeSnippets",
    },
  },
  load_snippets = {
    desc = "Load snippets for filetype",
    { event = "BufEnter", command = "LuasnipAutoloadFilteypeSnippets" },
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
      event = { "InsertLeave" },
      callback = require("ckolkey.utils.functions").update_buffer,
      nested = true,
    },
  },
  buffer_changed_timestamp = {
    desc = "Adds timestamp to buffer variables. Used by autosave function to throttle.",
    {
      event = { "BufWritePost", "BufEnter" },
      callback = function(event)
        vim.api.nvim_buf_set_var(event.buf, "timestamp", vim.fn.localtime())
      end,
    },
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
        local filetype = vim.api.nvim_buf_get_option(event.buf, "filetype")
        if filetype == "TelescopePrompt" then
          -- TODO: Prevent this from happening on WinEnter event
          return
        end

        local win_id = vim.api.nvim_get_current_win()
        vim.wo[win_id].cursorline = event.event == "WinEnter"
      end,
    },
  },
  read_secrets_as_binary = {
    desc = "Reads work secrets as binary files to prevent \n at EOL",
    {
      event = { "BufEnter" },
      pattern = { "*/pro-secrets/**", "*/kaila-secrets/**" },
      command = "setl binary noeol",
    },
  },
  neogit_worktree_create = {
    desc = "copies over files from main worktree that are not git tracked",
    {
      event = { "User" },
      pattern = "NeogitWorktreeCreate",
      callback = function(event)
        event.data.copy_if_present("Gemfile.dev")
        event.data.copy_if_present(".envrc", function()
          vim.system({ "direnv", "allow" }):wait()
        end)
      end
    }
  }
}

require("ckolkey.utils.autocmds").load(definitions)
