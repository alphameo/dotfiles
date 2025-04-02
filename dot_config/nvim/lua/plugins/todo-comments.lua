return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = true },
  config = function()
    require("todo-comments").setup()

    local map = vim.keymap.set
    map("n", "<leader>ft", ":TodoTelescope<cr>", { silent = true, desc = "Find TODOs" })
    map("n", "<leader>fT", ":TodoTelescope keywords=TODO,FIX,FIXME<cr>", { silent = true, desc = "Find TODO/FIX/..." })
  end,
}
