-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").sqlls.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.sql = { "sqlfmt" }

-- INFO: LINTING
require("lint").linters_by_ft.sql = { "sqlfluff" }
