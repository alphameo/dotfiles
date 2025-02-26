-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "marksman" then
  require("lspconfig").marksman.setup {
    capabilities = lsp_utils.capabilities,
  }
else
  vim.notify("marksman (markdown) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" }

-- INFO: LINTING
require("lint").linters_by_ft.markdown = { "markdownlint-cli2" }
