return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
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
    map("n", "<leader>rB", ":Refactor extract_block_to_file<CR>", { desc = "Refactor Extract Block to File" })

    require("telescope").load_extension "refactoring"

    map({ "n", "x" }, "<leader>rr", function() t_refactoring.refactors() end, { desc = "Refactor Menu" })
    map({ "n", "x" }, "<leader>cc", function() t_refactoring.refactors() end, { desc = "Refactor Menu" })
    map("n", "<leader>Dp", function() refactoring.debug.printf { below = false } end, { desc = "Debug Printf Marker" })
    map({ "x", "n" }, "<leader>Dv", function() refactoring.debug.print_var() end, { desc = "Debug Printf Variable" })
    map("n", "<leader>Dc", function() refactoring.debug.cleanup {} end, { desc = "Debug Printf Clear" })

    refactoring.setup {
      prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
    }
  end,
}
