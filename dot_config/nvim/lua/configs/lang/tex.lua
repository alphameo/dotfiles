-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "texlab" then
  require("lspconfig").texlab.setup {
    capabilities = lsp_utils.capabilities,
  }
else
  vim.notify("texlab (tex) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.tex = { "bibtex-tidy" }

-- -- INFO: LINTING
-- require("lint").linters_by_ft.tex = { "vale" }
