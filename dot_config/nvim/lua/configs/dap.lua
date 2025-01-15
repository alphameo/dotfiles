return {
  "mfussenegger/nvim-dap",
  recommended = true,
  dependencies = {
    -- Creates a beautiful debugger UI
    {
      "rcarriga/nvim-dap-ui",
      opts = {},
      config = function(_, opts)
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup {
          -- Set icons to characters that are more likely to work in every terminal.
          --    Feel free to remove or use ones that you like more! :)
          --    Don't feel like these are good choices.
          icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
          controls = {
            icons = {
              disconnect = "",
              pause = "",
              play = "",
              run_last = "",
              step_back = "",
              step_into = "",
              step_out = "",
              step_over = "",
              terminate = "",
            },
          },
        }

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        -- setup an event listener for when the debugger is launched
        -- when the debugger is launched open up the debug ui
        dap.listeners.before.launch.dapui_config = dapui.open
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    "nvim-neotest/nvim-nio",

    "williamboman/mason.nvim",
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "python",
          "cppdbg",
          "js",
          "codelldb",
          "bash",
          "javadbg",
          "javatest",
          "kotlin",
        },
      },
      -- mason-nvim-dap is loaded when nvim-dap loads
      config = function() end,
    },

    -- Inline variable text while debugging

    -- "nvim-telescope/telescope-dap.nvim", -- telescope integration with dap

    -- Add your own debuggers here
    -- "mfussenegger/nvim-dap-python",

    -- "fwcd/kotlin-debug-adapter",
  },

  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug () Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
    end, { desc = "Debug () Set Conditional Breakpoint" })

    vim.keymap.set("n", "<F29>", dapui.toggle, { desc = "Debug Toggle UI" })
    vim.keymap.set("n", "<leader>dd", dapui.toggle, { desc = "Debug Interface" })

    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug () Continue" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug () Continue" })
    vim.keymap.set("n", "<leader>da", function()
      dap.continue { before = get_args }
    end, { desc = "Debug (󱤵) Run with Args" })

    vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Debug () Run Last" })
    vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Debug () Pause" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug () Terminate" })

    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug () Step Over" })
    vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Debug ()  Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug () Step Into" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug () Step Into" })
    vim.keymap.set("n", "<F23>", dap.step_out, { desc = "Debug () Step Out" })
    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug () Step Out" })

    vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Debug Down" })
    vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Debug Up" })

    -- vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Debug Toggle REPL" })
    -- vim.keymap.set("n", "<leader>ds", dap.session, { desc = "Debug Session" })
    -- vim.keymap.set("n", "<leader>dw", require("dap.ui.widgets").hover, { desc = "Widgets" })

    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
      },
    }
  end,
}
