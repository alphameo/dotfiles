return {
  "folke/todo-comments.nvim",
  lazy = true,
  cmd = { "TodoTelescope" },
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = true },
  config = function()
    require("todo-comments").setup()

    local map = vim.keymap.set
    map("n", "<leader>ft", ":TodoTelescope<CR>", { silent = true, desc = "Find TODOs" })
    map("n", "<leader>fT", ":TodoTelescope keywords=TODO,FIX,FIXME<CR>", { silent = true, desc = "Find TODO/FIX/..." })
  end,
}
