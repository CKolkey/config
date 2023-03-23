local solargraph_cmd = function()
  if utils.file_in_cwd(".solargraph.yml") then
    if utils.file_in_cwd("bin/bundle") then
      return { vim.loop.cwd() .. "/bin/bundle", "exec", "solargraph", "stdio" }
    else
      return { "bundle", "exec", "solargraph", "stdio" }
    end
  else
    return { "solargraph", "stdio" }
  end
end

local prettierd = {
  formatCommand = "prettierd ${INPUT}",
  formatStdin = true,
  env = { string.format("PRETTIERD_DEFAULT_CONFIG=%s/.prettierrc.json", vim.fn.getcwd()) },
}

return {
  rust_analyzer = {},
  solargraph = {
    -- cmd = { "nc", "127.0.0.1", "7658" },
    cmd = solargraph_cmd(),
    -- capabilities = {
    --   textDocument = {
    --     publishDiagnostics = false,
    --     formatting = false
    --   }
    -- }
  },
  efm = {
    init_options = { documentFormatting = true },
    filetypes = { "javascript" },
    settings = {
      rootMarkers = { ".git/" },
      languages = {
        javascript = { prettierd }
      }
    }
  },
  tsserver = {
    disable_formatting = true
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "Lua 5.1",
          -- path = {
          --   '?.lua',
          --   '?/init.lua',
          -- }
        },
        format = {
          enable = false,
          defaultConfig = {
            indent_style     = "space",
            indent_size      = "2",
            quote_style      = "AutoPreferDouble",
            call_parentheses = "Always",
            column_width     = "120",
            line_endings     = "Unix",
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
