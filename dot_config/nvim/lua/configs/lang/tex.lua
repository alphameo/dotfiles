-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").texlab.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.tex = { "bibtex-tidy" }

-- -- INFO: LINTING
-- require("lint").linters_by_ft.tex = { "vale" }
