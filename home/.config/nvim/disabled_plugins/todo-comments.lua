return {
  "folke/todo-comments.nvim",
  lazy = true,
  cmd = { "TodoTelescope" },
  event = { "VeryLazy" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup {
      signs = true,
    }

    local map = vim.keymap.set
    map("n", "<leader>ft", ":TodoTelescope<CR>", { silent = true, desc = "Find TODOs" })
    map("n", "<leader>fT", ":TodoTelescope keywords=TODO,FIX,FIXME<CR>", { silent = true, desc = "Find TODO/FIX/..." })
  end,
}
