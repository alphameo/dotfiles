-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").taplo.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: FORMATTING
-- taplo

-- INFO: LINTING
-- taplo
