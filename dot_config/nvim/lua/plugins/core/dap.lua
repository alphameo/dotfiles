return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    dapui.setup()

    dap.listeners.before.attach.dapui_config = dapui.open
    -- dap.listeners.before.event_terminated.dapui_config = dapui.close
    -- dap.listeners.before.event_exited.dapui_config = dapui.close

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
