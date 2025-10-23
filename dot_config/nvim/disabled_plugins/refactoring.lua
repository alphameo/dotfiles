return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  -- stylua: ignore
  config = function()
    local map = vim.keymap.set
    local refactoring = require "refactoring"
    local t_refactoring = require("telescope").extensions.refactoring

    map("x", "<leader>re", ":Refactor extract ", { silent = true, desc = "Refactor Extract" })
    map("x", "<leader>rE", ":Refactor extract_to_file ", { silent = true, desc = "Refactor Extract to File" })
    map("x", "<leader>rv", ":Refactor extract_var ", { silent = true, desc = "Refactor Extract Variable" })
    map({ "n", "x" }, "<leader>ri", ":Refactor inline_var<CR>", { silent = true, desc = "Refactor Inline Variable" })
    map("n", "<leader>rI", ":Refactor inline_func<CR>", { silent = true, desc = "Refactor Inline Function" })
    map("n", "<leader>rb", ":Refactor extract_block<CR>", { silent = true, desc = "Refactor Extract Block" })
    map("n", "<leader>rB", ":Refactor extract_block_to_file<CR>", { silent = true, desc = "Refactor Extract Block to File" })

    require("telescope").load_extension "refactoring"

    map({ "n", "x" }, "<leader>rr",  t_refactoring.refactors, { desc = "Refactor Menu" })
    map({ "n", "x" }, "grR",  t_refactoring.refactors, { desc = "Refactor Menu" })
    map("n", "<leader>dP", function() refactoring.debug.printf { below = false } end, { desc = "Debug Printf Marker" })
    map({ "x", "n" }, "<leader>dV", refactoring.debug.print_var, { desc = "Debug Printf Variable" })
    map("n", "<leader>dC", refactoring.debug.cleanup, { desc = "Debug Printf Clear" })

    refactoring.setup {
      prompt_func_return_type = {
        go = true,
        c = true,
        h = true,
        cpp = true,
        hpp = true,
        cxx = true,
        java = true,
      },
      prompt_func_param_type = {
        go = true,
        c = true,
        h = true,
        cpp = true,
        hpp = true,
        cxx = true,
        java = true,
      },
    }
  end,
}
