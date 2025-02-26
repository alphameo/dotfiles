-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "lemminx" then
  require("lspconfig").lemminx.setup {
    capabilities = lsp_utils.capabilities(),
  }
else
  vim.notify("lemminx (xml) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.xml = { "xmlformatter" }

-- INFO: LINTING
-- lemminx
