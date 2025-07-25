return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    inlay_hints = { enabled = true },
    codelens = { enabled = true },
  },
  config = function()
    require("lsp").setup()
  end,
}
