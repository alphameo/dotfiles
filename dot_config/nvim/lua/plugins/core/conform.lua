return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require "conform"
    vim.keymap.set({ "n", "v", "i" }, "<C-S-i>", function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = "Code Format" })
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = "Code Format" })
  end,
}
