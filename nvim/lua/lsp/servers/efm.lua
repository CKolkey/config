local M = {}

local config = require("lsp.config")

local prettier = {
  formatCommand = "prettierd ${INPUT}",
  formatStdin = true,
  env = { string.format("PRETTIERD_DEFAULT_CONFIG=%s/.prettierrc.json", vim.fn.getcwd()) },
}

local stylua = {
  formatCommand = "stylua --config-path ~/.config/stylua/config.toml --stdin-filepath ${INPUT} -",
  formatStdin = true,
}

local languages = {
  lua = { stylua },
  eruby = { prettier },
  json = { prettier },
  scss = { prettier },
  javascript = { prettier },
}

function M.load()
  require("lspconfig").efm.setup({
    capabilities = config.capabilities,
    on_attach = config.on_attach_with_formatting,
    init_options = { documentFormatting = true },
    root_dir = vim.loop.cwd,
    filetypes = vim.tbl_keys(languages),
    settings = {
      lintDebounce = 100,
      rootMarkers = { ".git/" },
      languages = languages,
    },
  })
end

return M
