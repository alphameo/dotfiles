return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  lazy = true,
  event = { "VeryLazy" },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    dapui.setup()

    vim.cmd [[highlight DapBreakpointColor guifg=#fa4848]]
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointColor" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapBreakpointColor" })

    dap.listeners.before.attach.dapui_config = dapui.open
    -- dap.listeners.before.event_terminated.dapui_config = dapui.close
    -- dap.listeners.before.event_exited.dapui_config = dapui.close

    local map = vim.keymap.set
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug () Toggle Breakpoint" })
    map("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
    end, { desc = "Debug () Set Conditional Breakpoint" })

    map("n", "<F29>", dapui.toggle, { desc = "Debug Toggle UI" })
    map("n", "<leader>dd", dapui.toggle, { desc = "Debug Interface" })

    map("n", "<F5>", dap.continue, { desc = "Debug () Continue" })
    map("n", "<leader>dc", dap.continue, { desc = "Debug () Continue" })
    map("n", "<leader>da", function()
      dap.continue { before = get_args }
    end, { desc = "Debug (󱤵) Run with Args" })

    map("n", "<Leader>dl", dap.run_last, { desc = "Debug () Run Last" })
    map("n", "<leader>dp", dap.pause, { desc = "Debug () Pause" })
    map("n", "<leader>dt", dap.terminate, { desc = "Debug () Terminate" })

    map("n", "<F10>", dap.step_over, { desc = "Debug () Step Over" })
    map("n", "<leader>dO", dap.step_over, { desc = "Debug ()  Step Over" })
    map("n", "<F11>", dap.step_into, { desc = "Debug () Step Into" })
    map("n", "<leader>di", dap.step_into, { desc = "Debug () Step Into" })
    map("n", "<F23>", dap.step_out, { desc = "Debug () Step Out" })
    map("n", "<leader>do", dap.step_out, { desc = "Debug () Step Out" })

    map("n", "<leader>dj", dap.down, { desc = "Debug Down" })
    map("n", "<leader>dk", dap.up, { desc = "Debug Up" })

    -- map("n", "<leader>dr", dap.repl.toggle, { desc = "Debug Toggle REPL" })
    -- map("n", "<leader>ds", dap.session, { desc = "Debug Session" })
    -- map("n", "<leader>dw", require("dap.ui.widgets").hover, { desc = "Widgets" })

    -- INFO: DAP CCPP
    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb",
      -- detached = false, -- on windows you may have to uncomment this:
    }
    for _, lang in ipairs { "c", "cpp" } do
      dap.configurations[lang] = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end

    -- INFO: DAP JAVA
    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
      },
    }

    -- INFO: DAP KOTLIN
    dap.adapters.kotlin = {
      type = "executable",
      command = "kotlin-debug-adapter",
      options = { auto_continue_if_many_stopped = false },
    }
    dap.configurations.kotlin = {
      {
        type = "kotlin",
        request = "launch",
        name = "This file",
        mainClass = function()
          local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
          local fname = vim.api.nvim_buf_get_name(0)
          return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
        end,
        projectRoot = "${workspaceFolder}",
        jsonLogFile = "",
        enableJsonLogging = false,
      },
      {
        type = "kotlin",
        request = "attach",
        name = "Attach to debugging session",
        port = 5005,
        args = {},
        projectRoot = vim.fn.getcwd,
        hostName = "localhost",
        timeout = 2000,
      },
    }

    -- INFO: DAP PHP
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { os.getenv "HOME" .. ".local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
    }

    -- INFO: DAP JAVASCRIPT TYPESCRIPT
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          os.getenv "HOME" .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }
    dap.adapters.firefox = {
      type = "executable",
      command = "node",
      args = { os.getenv "HOME" .. "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
    }
    local js_based_langs = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
    }
    for _, language in ipairs(js_based_langs) do
      dap.configurations[language] = {
        {
          name = "Launch file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          name = "Debug with Firefox",
          type = "firefox",
          request = "launch",
          reAttach = true,
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          firefoxExecutable = "/usr/bin/firefox",
        },
      }
    end

    -- INFO: DAP C#
    dap.adapters.netcoredbg = {
      type = "executable",
      command = vim.fn.exepath "netcoredbg",
      args = { "--interpreter=vscode" },
      options = {
        detached = false,
      },
    }
    for _, lang in ipairs { "cs", "fsharp", "vb" } do
      if not dap.configurations[lang] then
        dap.configurations[lang] = {
          {
            type = "netcoredbg",
            name = "Launch file",
            request = "launch",
            program = function()
              return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end
  end,
}
