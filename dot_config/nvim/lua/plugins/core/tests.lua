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
    },
    lazy = true,
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local neotest = require "neotest"

      neotest.setup {
        adapters = {
          require "neotest-golang" {
            -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
            dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          },
          require "rustaceanvim.neotest",
          require "neotest-java" {
            junit_jar = nil, -- default: stdpath("data") .. /nvim/neotest-java/junit-platform-console-standalone-[version].jar
            incremental_build = true,
          },
        },
      }

      local map = vim.keymap.set
      map("n", "<leader>Tf", function()
        neotest.run.run(vim.fn.expand "%")
      end, { desc = "Test File" })
      map("n", "<leader>Tp", function()
        neotest.run.run(vim.uv.cwd())
      end, { desc = "Test Project" })
      map("n", "<leader>Tn", neotest.run.run, { desc = "Test Nearest" })
      map("n", "<leader>Tl", neotest.run.run_last, { desc = "Test Last" })
      map("n", "<leader>Ts", neotest.summary.toggle, { desc = "Test Summary" })
      map("n", "<leader>TT", function()
        neotest.output.open { enter = true, auto_close = true }
      end, { desc = "Test Output" })
      map("n", "<leader>Tt", neotest.output_panel.toggle, { desc = "Test Output" })
      map("n", "<leader>Tq", neotest.run.stop, { desc = "Test Stop" })
      map("n", "<leader>Tq", function()
        neotest.watch.toggle(vim.fn.expand "%")
      end, { desc = "Test Watch" })
    end,
  },
}
