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
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble Diagnostics" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble Buffer Diagnostics" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble Location List" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble Quickfix" },
    { "<leader>cst", "<cmd>Trouble symbols toggle<cr>", desc = "Code Symbols" },
    { "<leader>cl", "<cmd>Trouble lsp toggle<cr>", desc = "Code List Definitions / References / ... " },
  },
}
