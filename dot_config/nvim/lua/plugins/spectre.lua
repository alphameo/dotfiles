return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = true,
  event = "VeryLazy",
  -- stylua: ignore
  config = function()
    local spectre = require "spectre"
    local map = vim.keymap.set

    spectre.setup()
    map("n", "<leader>fRR", spectre.toggle, { desc = "Find&Replace Menu" })
    map("n", "<leader>fRW", function() spectre.open_visual { select_word = true } end, { desc = "Find&Repalce Word" })
    map("v", "<leader>fRW", '<ESC>:lua require("spectre").open_visual()<CR>', { desc = "Find&Replace Selected" })
    map("n", "<leader>fRF", function() spectre.open_file_search { select_word = true } end, { desc = "Find&Replace in File" })
  end,
}
