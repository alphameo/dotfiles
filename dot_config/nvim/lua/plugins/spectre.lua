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
    map("n", "<leader>FF", spectre.toggle, { desc = "F&Replace Menu Open" })
    map("n", "<leader>Fw", function() spectre.open_visual { select_word = true } end, { desc = "F&Repalce Word" })
    map("v", "<leader>Fw", '<ESC>:lua require("spectre").open_visual()<CR>', { desc = "F&Replace Word" })
    map("n", "<leader>Ff", function() spectre.open_file_search { select_word = true } end, { desc = "F&Replace on Current File" })
  end,
}
