return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  lazy = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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

    -- INFO: DAP CCPP
    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb",
      -- detached = false, -- on windows you may have to uncomment this:
      -- type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
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
      args = {
        require("mason-registry").get_package("php-debug-adapter"):get_install_path() .. "/extension/out/phpDebug.js",
      },
    }

    -- INFO: DAP PYTHON
    require("dap-python").setup(vim.env.HOME .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
    require("dap-python").default_port = 38000

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
  end,
}
