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
    { "<leader>xx", ":Trouble diagnostics toggle<cr>", desc = "Trouble Diagnostics" },
    { "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble Buffer Diagnostics" },
    { "<leader>xL", ":Trouble loclist toggle<cr>", desc = "Trouble Location List" },
    { "<leader>xq", ":Trouble qflist toggle<cr>", desc = "Trouble Quickfix List" },
    { "<leader>cst", ":Trouble symbols toggle<cr>", desc = "Code Symbols Tree" },
    { "<leader>cl", ":Trouble lsp toggle<cr>", desc = "Code List Definitions / References / ... " },
  },
}
