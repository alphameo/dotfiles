return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
  -- stylua: ignore
  config = function()
    local map = vim.keymap.set

    map("n", "<leader>xx", ":Trouble diagnostics toggle<cr>", { silent = true, desc = "Trouble Diagnostics" })
    map("n", "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<cr>", { silent = true, desc = "Trouble Buffer Diagnostics" })
    map("n", "<leader>xL", ":Trouble loclist toggle<cr>", { silent = true, desc = "Trouble Location List" })
    map("n", "<leader>xq", ":Trouble qflist toggle<cr>", { silent = true, desc = "Trouble Quickfix List" })
    map("n", "<leader>cst", ":Trouble symbols toggle<cr>", { silent = true, desc = "Code Symbols Tree" })
    map("n", "<leader>cl", ":Trouble lsp toggle<cr>", { silent = true, desc = "Code List Definitions / References / ... " })
  end,
}
