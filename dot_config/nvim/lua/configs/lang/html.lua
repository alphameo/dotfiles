-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").html.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.html = { "prettierd" }

-- INFO: LINTING
require("lint").linters_by_ft.html = { "htmlhint" }
