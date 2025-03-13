-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").bashls.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.sh = { "shfmt" }
require("conform").formatters_by_ft.zsh = { "shfmt" }
require("conform").formatters_by_ft.bash = { "shfmt" }

-- INFO: LINTING
require("lint").linters_by_ft.bash = { "shellcheck" }
