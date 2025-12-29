return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
      "rcasia/neotest-java",
      "nvim-neotest/neotest-python",
    },
    lazy = true,
    event = { "VeryLazy" },
    config = function()
      local neotest = require "neotest"

      neotest.setup {
        adapters = {
          -- INFO: FILENAME: test_my.py
          require "neotest-python" {},

          require "neotest-golang" {
            -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
            dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          },

          -- require "rustaceanvim.neotest",
          --
          -- NOTE: FILENAME: MyTest.java
          require "neotest-java" {
            junit_jar = os.getenv "HOME"
              .. "/.local/share/nvim/neotest-java/junit-platform-console-standalone-1.10.1.jar",
            -- junit_jar = vim.fn.glob(os.getenv "HOME" .. "/.local/share/nvim/neotest-java/junit-platform-console-standalone-*.jar"),
            -- junit_jar = nil, -- default: stdpath("data") .. /.local/share/nvim/neotest-java/junit-platform-console-standalone-[version].jar
            incremental_build = true,
          },
        },
      }

      local map = vim.keymap.set
      map("n", "<leader>Ta", function()
        neotest.run.run(vim.fn.expand "%")
      end, { desc = "Test File" })
      map("n", "<leader>Tp", function()
        neotest.run.run(vim.uv.cwd())
      end, { desc = "Test Project" })
      map("n", "<leader>Tt", neotest.run.run, { desc = "Test Nearest" })
      map("n", "<leader>Tl", neotest.run.run_last, { desc = "Test Last" })
      map("n", "<leader>TT", neotest.summary.toggle, { desc = "Test Summary" })
      -- map("n", "<leader>TO", function()
      --   neotest.output.open { enter = true, auto_close = true }
      -- end, { desc = "Test Output" })
      map("n", "<leader>To", neotest.output_panel.toggle, { desc = "Test Output" })
      map("n", "<leader>Tq", neotest.run.stop, { desc = "Test Stop" })
      map("n", "<leader>Tw", function()
        neotest.watch.toggle(vim.fn.expand "%")
      end, { desc = "Test Watch" })
    end,
  },
}
