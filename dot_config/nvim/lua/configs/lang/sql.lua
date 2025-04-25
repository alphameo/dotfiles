-- INFO: LSP
vim.lsp.enable "sqlls"

-- INFO: FORMATTING
require("conform").formatters_by_ft.sql = { "sqlfmt" }

-- INFO: LINTING
require("lint").linters_by_ft.sql = { "sqlfluff" }
