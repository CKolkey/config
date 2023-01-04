local solargraph_cmd = function()
  if utils.file_in_cwd(".solargraph.yml") then
    return { "bundle", "exec", "solargraph", "stdio" }
  else
    return { "solargraph", "stdio" }
  end
end

local servers = {
  solargraph = {
    -- cmd = { "nc", "localhost", "7658" },
    cmd = solargraph_cmd()
  },
  tsserver = {},
  sumneko_lua = {
    settings = {
      Lua = {
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            quote_style = "AutoPreferDouble",
            call_parentheses = "Always",
            column_width = "120",
            line_endings = "Unix",
          },
        },
        diagnostics = {
          enable = true,
          neededFileStatus = {
            ["codestyle-check"] = "Any",
          },
          globals = { "vim", "hs" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
}

local function on_attach(client, bufnr)
  if client.supports_method("textDocument/signatureHelp") then
    require("lsp_signature").on_attach({ fixpos = true, padding = " " }, bufnr)
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_buf_set_var(bufnr, "format_with_lsp", true)
  end

  local keymaps = {
    normal = {
      ["<c-]"]             = { vim.lsp.buf.definition, { buffer = true } },
      ["gr"]               = { require("telescope.builtin").lsp_references, { buffer = true } },
      ["gi"]               = { require("telescope.builtin").lsp_implementations, { buffer = true } },
      ["<c-s>"]            = { require("telescope.builtin").lsp_workspace_symbols, { buffer = true } },
      ["<leader><leader>"] = { function() require("plugins.lsp.formatting").callback(client, bufnr) end,
        { buffer = true } }
    }
  }

  local autocmds = {
    lsp_diagnostics_hover = {
      desc = "Show diagnostics when you hold cursor",
      {
        event = "CursorHold",
        callback = require("plugins.lsp.diagnostics").callback,
        buffer = bufnr
      }
    },
    lsp_format_on_save = {
      desc = "Format buffer on save",
      {
        event    = "BufWritePost",
        callback = function() require("plugins.lsp.formatting").callback(client, bufnr) end,
        buffer   = bufnr,
      }
    }
  }

  require("utils.keymaps").load(keymaps)
  require("utils.autocmds").load(autocmds)
end

return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "ray-x/lsp_signature.nvim",
    "stevearc/dressing.nvim",
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("plugins.lsp.diagnostics").setup()
    require("plugins.lsp.formatting").setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local options = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }

    for server, opts in pairs(servers) do
      opts = vim.tbl_deep_extend("force", {}, options, opts or {})
      require("lspconfig")[server].setup(opts)
    end
  end
}
