-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").lemminx.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.xml = { "xmlformatter" }

-- INFO: LINTING
-- lemminx
