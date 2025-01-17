local lspconfig = require "lspconfig"

local capabilities = require("configs.lspconfig").capabilities
lspconfig.pyright.setup {
  capabilities = capabilities,
  filetypes = { "python" },
}
