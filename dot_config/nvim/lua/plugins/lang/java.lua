return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    require("lspconfig").jdtls.setup {}
  end,
}
