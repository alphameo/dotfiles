-- INFO: LSP
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
    },
    hints = {
      rangeVariableTypes = true,
      parameterNames = true,
      constantValues = true,
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      functionTypeParameters = true,
    },
  },
})
vim.lsp.enable "gopls"

-- INFO: DAP
require("dap-go").setup()
