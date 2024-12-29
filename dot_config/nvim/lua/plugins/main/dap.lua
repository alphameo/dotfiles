return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",

    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Inline variable text while debugging
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    "nvim-telescope/telescope-dap.nvim", -- telescope integration with dap

    -- Add your own debuggers here
    "mfussenegger/nvim-dap-python",

    "fwcd/kotlin-debug-adapter",
  },

  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    require("mason-nvim-dap").setup {
      -- automatic_setup = true,
      automatic_installation = true,

      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "python",
        "cppdbg",
        -- "delve",
        -- "node2",
        -- "chrome",
        -- "firefox",
        -- "php",
        -- "corecrl",
        "js",
        "codelldb",
        "bash",
        "javadbg",
        "javatest",
        "kotlin",
        -- "mock",
        -- "puppet",
        -- "elixir",
        -- "kotlin",
        -- "dart",
        -- "haskell",
        -- "erlang",
      },
    }

    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
    end, { desc = "Debug Set Conditional Breakpoint" })

    vim.keymap.set("n", "<F29>", dapui.toggle, { desc = "Debug Toggle UI" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug UI" })

    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug Continue" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug Continue" })
    vim.keymap.set("n", "<leader>da", function()
      dap.continue { before = get_args }
    end, { desc = "Debug Run with Args" })

    vim.keymap.set("n", "<leader>dt", function()
      dap.terminate()
    end, { desc = "Debug Terminate" })

    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug Step Over" })
    vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Debug Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug Step Into" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug Step Into" })
    vim.keymap.set("n", "<F23>", dap.step_out, { desc = "Debug Step Out" })
    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug Step Out" })

    vim.keymap.set("n", "<leader>dp", function()
      dap.pause()
    end, { desc = "Debug Pause" })

    vim.keymap.set("n", "<leader>dj", function()
      dap.down()
    end, { desc = "Debug Down" })
    vim.keymap.set("n", "<leader>dk", function()
      dap.up()
    end, { desc = "Debug Up" })

    vim.keymap.set("n", "<Leader>dl", function()
      require("dap").run_last()
    end, { desc = "Debug Run Last" })

    vim.keymap.set("n", "<leader>dr", function()
      dap.repl.toggle()
    end, { desc = "Debug Toggle REPL" })

    vim.keymap.set("n", "<leader>ds", function()
      dap.session()
    end, { desc = "Debug Session" })

    vim.keymap.set("n", "<leader>dw", function()
      require("dap.ui.widgets").hover()
    end, { desc = "Widgets" })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          disconnect = " ",
          pause = "",
          play = "",
          run_last = " ",
          step_back = " ",
          step_into = " ",
          step_out = " ",
          step_over = " ",
          terminate = " ",
        },
      },
    }

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- setup an event listener for when the debugger is launched
    dap.listeners.before.launch.dapui_config = function()
      -- when the debugger is launched open up the debug ui
      dapui.open()
    end

    dap.configurations.java = {
      {
        name = "Debug Launch (2GB)",
        type = "java",
        request = "launch",
        vmArgs = "" .. "-Xmx2g ",
      },
      -- {
      -- 	name = "Debug Attach (8000)",
      -- 	type = "java",
      -- 	request = "attach",
      -- 	hostName = "127.0.0.1",
      -- 	port = 8000,
      -- },
      -- {
      -- 	name = "Debug Attach (5005)",
      -- 	type = "java",
      -- 	request = "attach",
      -- 	hostName = "127.0.0.1",
      -- 	port = 5005,
      -- },
      -- {
      -- 	name = "My Custom Java Run Configuration",
      -- 	type = "java",
      -- 	request = "launch",
      -- 	-- You need to extend the classPath to list your dependencies.
      -- 	-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
      -- 	-- classPaths = {},
      --
      -- 	-- If using multi-module projects, remove otherwise.
      -- 	-- projectName = "yourProjectName",
      --
      -- 	-- javaExec = "java",
      -- 	mainClass = "replace.with.your.fully.qualified.MainClass",
      --
      -- 	-- If using the JDK9+ module system, this needs to be extended
      -- 	-- `nvim-jdtls` would automatically populate this property
      -- 	-- modulePaths = {},
      -- 	vmArgs = "" .. "-Xmx2g ",
      -- },
    }

    dap.configurations.kotlin = {
      {
        type = "kotlin",
        request = "launch",
        name = "This file",
        -- may differ, when in doubt, whatever your project structure may be,
        -- it has to correspond to the class file located at `build/classes/`
        -- and of course you have to build before you debug
        mainClass = function()
          local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
          local fname = vim.api.nvim_buf_get_name(0)
          -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
          return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
        end,
        projectRoot = "${workspaceFolder}",
        jsonLogFile = "",
        enableJsonLogging = false,
      },
      {
        -- Use this for unit tests
        -- First, run
        -- ./gradlew --info cleanTest test --debug-jvm
        -- then attach the debugger to it
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

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "127.0.0.1",
      port = 8123,
      executable = {
        command = "js-debug-adapter",
      },
    }

    for _, language in ipairs { "typescript", "javascript" } do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
        },
      }
    end

    require("dap-python").setup()

    dap.adapters.kotlin = {
      type = "executable",
      command = "kotlin-debug-adapter",
      options = { auto_continue_if_many_stopped = false },
    }
  end,
}
