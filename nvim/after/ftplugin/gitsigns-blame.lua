vim.keymap.set("n", "q", vim.cmd.quit, { buffer = true })
vim.keymap.set("n", "<leader>gb", vim.cmd.quit, { buffer = true })

local function get_sha()
  -- We need the bufnr for the _alt_ buffer, as our current buffer is the git blame,
  -- and gitsigns keys the cache by the actual file's bufnr.
  local bufnr = vim.fn.getbufinfo("#")[1].bufnr

  local cache = require('gitsigns.cache').cache
  local bcache = cache[bufnr]
  if not bcache then
    print("Gitsigns not attached")
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(0)[1]
  local blame = assert(bcache.blame)
  local sha = assert(blame[cursor]).commit.sha

  return sha
end

vim.keymap.set("n", "o", function()
  local sha = get_sha()
  if sha then
    local NeogitCommitView = require("neogit.buffers.commit_view")
    local view = NeogitCommitView.new(sha)
    view:open("floating")

    view.buffer:set_window_option("scrollbind", false)
    view.buffer:set_window_option("cursorbind", false)
  end
end, { buffer = true })

vim.keymap.set("n", "d", function()
  local sha = get_sha()
  if sha then
    vim.cmd("DiffviewOpen " .. sha .. "^.." .. sha)
  end
end, { buffer = true })
