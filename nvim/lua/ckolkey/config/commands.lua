local definitions = {
  ["Messages"] = function()
    local scratch_buffer = vim.api.nvim_create_buf(false, true)
    vim.bo[scratch_buffer].filetype = "vim"
    local messages = vim.split(vim.fn.execute("messages", "silent"), "\n")

    vim.api.nvim_buf_set_text(scratch_buffer, 0, 0, 0, 0, messages)
    vim.cmd("vertical sbuffer " .. scratch_buffer)
  end,
  ["ProfileStart"] = function()
    require("plenary.profile").start("profile.log", { flame = true })
    -- vim.api.nvim_create_autocmd("VimLeavePre", { callback = require("plenary.profile").stop })
  end,
  ["ProfileStop"] = require("plenary.profile").stop
}

require("ckolkey.utils.commands").load(definitions)
