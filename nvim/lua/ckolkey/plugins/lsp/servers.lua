local prettierd = {
  formatCommand = "prettierd ${INPUT}",
  formatStdin = true,
  env = { string.format("PRETTIERD_DEFAULT_CONFIG=%s/.prettierrc.json", vim.fn.getcwd()) },
}

return {
  rust_analyzer = {},
  bashls = {},
  ruby_lsp = {
    init_options = {
      featuresConfiguration = {
        inlayHint = {
          enableAll = true,
        },
      },
    },
  },
  -- pylsp = {},
  efm = {
    init_options = { documentFormatting = true },
    filetypes = {
      "python",
      "yaml",
      "lua",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    settings = {
      rootMarkers = { ".git/" },
      languages = {
        ["python"] = {
          {
            formatCommand = "poetry run black --quiet -",
            formatStdin = true,
            rootMarkers = { "poetry.lock" },
          },
        },
        ["yaml"] = {
          -- {
          --   formatCommand = "yamlfmt -in ${INPUT}",
          --   formatStdin = true,
          -- },
          {
            lintCommand = "yamllint -f parsable -",
            lintStdin = true,
            -- lintIgnoreExitCode = true
          },
        },
        -- ["lua"] = {
        --   {
        --     formatCommand = "stylua --color Never -",
        --     formatStdin = true,
        --     rootMarkers = { "stylua.toml", ".stylua.toml" },
        --   },
        -- },
        ["javascript"] = { prettierd },
        ["javascriptreact"] = { prettierd },
        ["javascript.jsx"] = { prettierd },
        ["typescript"] = { prettierd },
        ["typescriptreact"] = { prettierd },
        ["typescript.tsx"] = { prettierd },
      },
    },
  },
  ts_ls = {
    init_options = {
      documentFormatting = false,
      hostInfo = "neovim",
    },
  },
  lua_ls = {
    -- init_options = { documentFormatting = false },
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
        hint = {
          enable = true,
          setType = true,
        },
        diagnostics = {
          enable = true,
          neededFileStatus = {
            ["codestyle-check"] = "Any",
          },
          globals = { "vim", "hs" },
        },
        workspace = {
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}
