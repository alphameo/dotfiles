return {
  "mfussenegger/nvim-jdtls",
  lazy = true,
  ft = { "java" },
  config = function()
    require("lsp").setup_java()
  end,
}
