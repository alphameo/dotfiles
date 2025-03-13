-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").intelephense.setup {
  capabilities = lsp_utils.capabilities,
}

require("lspconfig").phpactor.setup {
  capabilities = lsp_utils.capabilities,
}

-- INFO: DAP
local dap = require "dap"
local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { path .. "/extension/out/phpDebug.js" },
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.php = { "php_cs_fixer" }

-- INFO: LINTING
require("lint").linters_by_ft.php = { "phpcs" }
