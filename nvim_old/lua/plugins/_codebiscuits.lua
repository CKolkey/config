local M = {}

M.config = function()
  require("nvim-biscuits").setup({
    -- toggle_keybind = "<leader>cb",
    -- show_on_start = true,
    -- cursor_line_only = false,
    -- trim_by_words = true,
    -- default_config = {
    --   max_length = 2,
    --   min_distance = 5,
    --   prefix_string = "# ",
    -- },
    -- language_config = {
    --   ruby = { prefix_string = "# " },
    --   embedded_template = { disabled = true }, -- eruby
    --   javascript = { prefix_string = "// " },
    -- },
  })
end

return M
