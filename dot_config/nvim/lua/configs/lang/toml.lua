-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "taplo" then
  require("lspconfig").taplo.setup {
    capabilities = lsp_utils.capabilities(),
  }
else
  vim.notify("taplo (toml) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
-- taplo

-- INFO: LINTING
-- taplo
