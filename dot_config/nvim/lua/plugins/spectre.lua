return {
  "nvim-pack/nvim-spectre",
  -- stylua: ignore
  config = function()
    local spectre = require "spectre"
    local map = vim.keymap.set

    spectre.setup {
      default = {
        replace = {
          cmd = "sed",
        },
      },
    }
    map("n", "<leader>FF", spectre.toggle, { desc = "Find & Replace Menu Open" })
    map("n", "<leader>Fw", function() spectre.open_visual { select_word = true } end, { desc = "Find & Repalce Word" })
    map("v", "<leader>Fw", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Find & Replace Word" })
    map("n", "<leader>Ff", function() spectre.open_file_search { select_word = true } end, { desc = "Find & Replace on Current File" })
  end,
}
