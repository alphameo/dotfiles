return {
  "mfussenegger/nvim-dap",
  recommended = true,
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      opts = {},
      config = function(_, opts)
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup {
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
  },

  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
      },
    }

    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb",
      -- detached = false, -- on windows you may have to uncomment this:
    }
    for _, lang in ipairs { "c", "cpp" } do
      dap.configurations[lang] = {
        {
          type = "codelldb",
          request = "launch",
          name = "Launch file",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "codelldb",
          request = "attach",
          name = "Attach to process",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

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
  end,
}
