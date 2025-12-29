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
  keys = {
    { "<leader>xx", ":Trouble diagnostics toggle<cr>", silent = true, desc = "Trouble Diagnostics" },
    { "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<cr>", silent = true, desc = "Trouble Buffer Diagnostics" },
    { "<leader>xl", ":Trouble loclist toggle<cr>", silent = true, desc = "Trouble Location List" },
    { "<leader>xq", ":Trouble qflist toggle<cr>", silent = true, desc = "Trouble Quickfix List" },
    { "<leader>cst", ":Trouble symbols toggle<cr>", silent = true, desc = "Code Symbols Tree" },
    { "<leader>cl", ":Trouble lsp toggle<cr>", silent = true, desc = "Code List Definitions / References / ... " },
  },
}
