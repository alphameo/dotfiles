-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "sql-language-server" then
  require("lspconfig").sqlls.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("sql-language-server (sql) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.sql = { "sqlfmt" }

-- INFO: LINTING
require("lint").linters_by_ft.sql = { "sqlfluff" }
