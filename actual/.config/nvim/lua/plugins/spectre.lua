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
    map("n", "<leader>rr", spectre.toggle, { desc = "Replace Menu" })
    map("n", "<leader>rw", function() spectre.open_visual { select_word = true } end, { desc = "Repalce Word" })
    map("v", "<leader>rw", '<ESC>:lua require("spectre").open_visual()<CR>', { desc = "Replace Selected" })
    map("n", "<leader>rf", function() spectre.open_file_search { select_word = true } end, { desc = "Replace in File" })
  end,
}
