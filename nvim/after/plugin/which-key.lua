local ok, wk = pcall(require, "which-key")
if ok then
  local n_mappings = {
    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },
    ["[g"] = "Git hunk",
    ["]g"] = "Git hunk",
    ["<leader>s"] = {
      name = "+Split",
      h = { ":vsplit<cr>", "Split Left" },
      j = { ":split<cr>:wincmd k<cr>", "Split Below" },
      k = { ":split<cr>", "Split Above" },
      l = { ":vsplit<cr>:wincmd h<cr>", "Split Right" },
    },
    ["<leader>f"] = {
      name = "+File Operations",
      c = { require("genghis").createNewFile, "Create File" },
      x = { require("genghis").chmodx, "chmod +x" },
      y = { require("genghis").copyFilename, "Copy Filename" },
      Y = { require("genghis").copyFilepath, "Copy Filepath" },
      r = { require("genghis").renameFile, "Rename File" },
      d = { require("genghis").duplicateFile, "Duplicate File" },
      T = { require("genghis").trashFile, "Trash File" },
      m = { require("genghis").moveAndRenameFile, "Move & Rename File" },
      s = { require("genghis").moveSelectionToNewFile, "Extract Selection" },
    },
    ["<leader>l"] = {
      name = "+lsp",
      d = { "telescope: definitions" },
      D = { "telescope: diagnostics" },
      t = { "telescope: type definitions" },
      r = { "telescope: references" },
      s = { "telescope: document symbols" },
      S = { "telescope: workspace symbols" },
      w = { "telescope: dynamic workspace symbols" },
      n = { "lsp: rename" },
      i = { name = "lsp: info" },
    },
    ["<leader>g"] = {
      name = "+git",
    },
    ["<leader>d"] = { name = "+diff" },
    c = {
      name = "+git-conflict",
      ["0"] = "Resolve with _None",
      t = "Resolve with _Theirs",
      o = "Resolve with _Ours",
      b = "Resolve with _Both",
      q = { "Send conflicts to _Quickfix" },
    },
    ["[c"] = { "<cmd>GitConflictPrevConflict<CR>", "go to prev conflict" },
    ["]c"] = { "<cmd>GitConflictNextConflict<CR>", "go to next conflict" },
  }

  local x_mappings = {
    ["<leader>f"] = {
      name = "+File Operations",
      s = { require("genghis").moveSelectionToNewFile, "Extract Selection" },
    },
  }

  wk.register(n_mappings, { mode = "n" })
  wk.register(x_mappings, { mode = "x" })
end
