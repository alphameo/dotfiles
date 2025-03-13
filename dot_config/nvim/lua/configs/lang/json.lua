-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").jsonls.setup {
  capabilities = lsp_utils.capabilities,

  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = {
        enable = true,
      },
    },
  },
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.json = { "prettierd" }

-- INFO: LINTING
require("lint").linters_by_ft.json = { "jsonlint" }
