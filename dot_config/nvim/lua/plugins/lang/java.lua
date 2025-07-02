return {
  "mfussenegger/nvim-jdtls",
  lazy = true,
  ft = { "java" },
  config = function()
    require("lsp").start_or_attach_java()
  end,
}
