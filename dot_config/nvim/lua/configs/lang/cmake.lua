-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").neocmake.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.cmake = { "gersemi" }

-- INFO: LINTING
require("lint").linters_by_ft.cmake = { "cmakelint" }
