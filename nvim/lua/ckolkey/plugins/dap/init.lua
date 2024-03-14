vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = " ", texthl = "Constant", linehl = "DapStoppedLine" })
vim.fn.sign_define("DapBreakpointRejected", { text = " " })

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "LiadOz/nvim-dap-repl-highlights",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "suketa/nvim-dap-ruby",
    },
    config = function()
      local dap = require("dap")
      dap.defaults.fallback.external_terminal = {
        command = "/opt/homebrew/bin/kitty",
        args = {
          "--class",
          "kitty-dap",
          "--hold",
          "--detach",
          "nvim-dap",
          "-c",
          "DAP"
        },
      }

      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({
          type = "server",
          host = config.host or "127.0.0.1",
          port = config.port or 8086,
        })
      end

      dap.adapters.ruby = function(callback, config)
        callback {
          type = "server",
          host = "127.0.0.1",
          port = "${port}",
          executable = {
            command = "bundle",
            args = {
              "exec",
              "rdbg",
              "-n",
              "--open",
              "--port",
              "${port}",
              "-c",
              "--",
              "bundle",
              "exec",
              config.command,
              config.script,
            },
          },
        }
      end

      dap.configurations.ruby = {
        {
          type = "ruby",
          name = "debug current file",
          request = "attach",
          localfs = true,
          command = "ruby",
          script = "${file}",
        },
        {
          type = "ruby",
          name = "run current spec file",
          request = "attach",
          localfs = true,
          command = "rspec",
          script = "${file}",
        },
      }
    end,
    keys = {
      {
        "<F7>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step into",
      },
      {
        "<F8>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Continue",
      },
      {
        "<leader>DC",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Continue",
      },
      {
        "<F9>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step over",
      },
      {
        "<F20>", -- Shift + <F8>
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle breakpoint",
      },
      {
        "<F21>", -- Shift + <F9>
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step out",
      },

      {
        "<leader>Db",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Set breakpoint",
      },
      {
        "<leader>Dp",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        desc = "Set log point",
      },
      {
        "<leader>Dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>Dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run last",
      },
    },
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    lazy = false,
    keys = {
      {
        "<leader>Ds",
        function()
          require("osv").launch({ port = 8086 })
        end,
        desc = "Start",
      },
      {
        "<leader>DS",
        function()
          require("osv").stop()
        end,
        desc = "Stop",
      },
    },
  },
  {
    "LiadOz/nvim-dap-repl-highlights",
    lazy = true,
    opts = {},
  },
  {
    "suketa/nvim-dap-ruby",
    lazy = true,
    config = function()
      require("dap-ruby").setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      -- floating = {
      --   border = custom.border,
      -- },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 30,
        },
        {
          elements = {
            -- dap-repl is managed by nvim-dap
            -- {
            --   id = "repl",
            --   size = 0.5,
            -- },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 15,
        },
      },
    },
    keys = {
      {
        "<leader>Du",
        function()
          require("dapui").toggle({ layout = 1 })
        end,
        desc = "Toggle UI sidebar",
      },
      {
        "<leader>DU",
        function()
          require("dapui").toggle({})
        end,
        desc = "Toggle UI",
      },
      {
        "<leader>Dc",
        function()
          require("dapui").toggle({ layout = 2 })
        end,
        desc = "Toggle console",
      },
      {
        "<leader>De",
        function()
          require("dapui").eval()
        end,
        desc = "Evaluate expression",
        mode = { "n", "v" },
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {},
  },
}
