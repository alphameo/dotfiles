return {
  {
    "folke/zen-mode.nvim",
    lazy = true,
    event = "LazyVim",
    config = function()
      local zen = require "zen-mode"
      vim.keymap.set("n", "<leader>az", function()
        zen.setup {
          window = {
            width = 90,
            options = {},
          },
        }
        zen.toggle()
        vim.wo.wrap = false
        vim.wo.number = true
        vim.wo.rnu = true
      end, { silent = true, desc = "Toggle Zen" })

      vim.keymap.set("n", "<leader>aZ", function()
        zen.setup {
          window = {
            width = 80,
            options = {},
          },
        }
        zen.toggle()
        vim.wo.wrap = false
        vim.wo.number = false
        vim.wo.rnu = false
        vim.opt.colorcolumn = "0"
      end, { silent = true, desc = "Toggle Zen Numless" })
    end,
  },
  {
    "folke/twilight.nvim",
    opts = {},
  },
}
