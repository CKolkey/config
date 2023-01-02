local excluded_filetypes = {
  "NeogitCommitView",
  "terminal",
  "TelescopePromptNormal",
  "neo-tree",
}

return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true,
      execution_message = {
        message = "Saved",
        cleaning_interval = 1000,
        dim = 0.18
      },
      trigger_events = { "InsertLeave" },
      debounce_delay = 135,
      condition = function(buf)
        if vim.opt.modifiable:get()
          and vim.fn.mode() == "n"
          and not vim.tbl_contains(excluded_filetypes, vim.opt.filetype:get())
          and not (vim.b.saving_format or false)
          and (vim.b.last_format_changedtick or 0) ~= vim.api.nvim_buf_get_changedtick(buf)

          then return true
          end

          return false
        end,
      })
    end
  }
