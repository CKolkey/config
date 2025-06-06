return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "ray-x/lsp_signature.nvim",
    "stevearc/dressing.nvim",
    -- "hrsh7th/cmp-nvim-lsp",
    "netmute/ctags-lsp.nvim",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local completion = require("cmp_nvim_lsp").default_capabilities(capabilities)

    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
    capabilities.textDocument.completion = completion.textDocument.completion
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    for server, opts in pairs(require("ckolkey.plugins.lsp.servers")) do
      local options = {
        -- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
        capabilities = capabilities,
        on_attach = require("ckolkey.plugins.lsp.on_attach")(opts),
        flags = {
          debounce_text_changes = 150,
        },
      }

      opts = vim.tbl_deep_extend("force", {}, options, opts or {})
      require("lspconfig")[server].setup(opts)
    end
  end,
}
