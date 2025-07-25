return {
  "folke/ts-comments.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("ts-comments").setup()
  end,
}
