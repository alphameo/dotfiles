return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java", -- Enable only on .java file extensions
    config = function()
      require("lspconfig").jdtls.setup {}
    end,
  },
}
