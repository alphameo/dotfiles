return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = true },
  -- stylua: ignore
  config = function()
    require("todo-comments").setup()
    vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>", { silent = true, desc = "Find TODOs" })
    vim.keymap.set("n", "<leader>fT", ":TodoTelescope keywords=TODO,FIX,FIXME<cr>", { silent = true, desc = "Find TODO/FIX/..." })
  end,
}
