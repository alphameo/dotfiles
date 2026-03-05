return {
  "j-hui/fidget.nvim",
  version = "*",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("fidget").setup()
  end,
}
