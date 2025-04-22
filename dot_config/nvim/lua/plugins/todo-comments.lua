return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  lazy = true,
  cmd = { "TodoTelescope" },
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = { signs = true },
  keys = {
    { mode = "n", "<leader>ft", ":TodoTelescope<cr>", silent = true, desc = "Find TODOs" },
    {
      mode = "n",
      "<leader>fT",
      ":TodoTelescope keywords=TODO,FIX,FIXME<cr>",
      silent = true,
      desc = "Find TODO/FIX/...",
    },
  },
  config = function()
    require("todo-comments").setup()
  end,
}
