return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require "conform"
    local fmt = function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end
    vim.keymap.set({ "n", "v", "i" }, "<C-S-i>", fmt, { desc = "Code Format" })
    vim.keymap.set({ "n", "v" }, "<leader>cf", fmt, { desc = "Code Format" })
  end,
}
