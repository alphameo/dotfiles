-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").marksman.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" }

-- INFO: LINTING
require("lint").linters_by_ft.markdown = { "markdownlint-cli2" }
