local ok, wk = pcall(require, "which-key")
if ok then
  local n_mappings = {
    cr = {
      name = "+coercion",
      s = { desc = "snake_case" },
      p = { desc = "PascalCase" },
      c = { desc = "camelCase" },
      u = { desc = "SCREAMING_SNAKE_CASE" },
      k = { desc = "kebab-case" },
      t = { desc = "Title Case (not reversible)" },
      ["-"] = { desc = "Kebab Case (not reversible)" },
      ["."] = { desc = "Dot Case   (not reversible)" },
      ["<space>"] = { desc = "Space Case (not reversible)" },
    },
    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },
    ["[g"] = "Git hunk",
    ["]g"] = "Git hunk",
    ["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
    ["[d"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
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
      name = "+Git",
      h = {
        name = "+Github",
        c = {
          name = "+Commits",
          c = { "<cmd>GHCloseCommit<cr>", "Close" },
          e = { "<cmd>GHExpandCommit<cr>", "Expand" },
          o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
          p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
          z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
        },
        i = {
          name = "+Issues",
          p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
        },
        l = {
          name = "+Litee",
          t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
        },
        r = {
          name = "+Review",
          b = { "<cmd>GHStartReview<cr>", "Begin" },
          c = { "<cmd>GHCloseReview<cr>", "Close" },
          d = { "<cmd>GHDeleteReview<cr>", "Delete" },
          e = { "<cmd>GHExpandReview<cr>", "Expand" },
          s = { "<cmd>GHSubmitReview<cr>", "Submit" },
          z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
        },
        p = {
          name = "+Pull Request",
          c = { "<cmd>GHClosePR<cr>", "Close" },
          d = { "<cmd>GHPRDetails<cr>", "Details" },
          e = { "<cmd>GHExpandPR<cr>", "Expand" },
          o = { "<cmd>GHOpenPR<cr>", "Open" },
          p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
          r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
          t = { "<cmd>GHOpenToPR<cr>", "Open To" },
          z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
        },
        t = {
          name = "+Threads",
          c = { "<cmd>GHCreateThread<cr>", "Create" },
          n = { "<cmd>GHNextThread<cr>", "Next" },
          t = { "<cmd>GHToggleThread<cr>", "Toggle" },
        },
      },
      c = {
        name = "+git-conflict",
        ["0"] = "Resolve with _None",
        t = "Resolve with _Theirs",
        o = "Resolve with _Ours",
        b = "Resolve with _Both",
        q = { "Send conflicts to _Quickfix" },
      },
    },
    ["<leader>d"] = { name = "+diff" },
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
