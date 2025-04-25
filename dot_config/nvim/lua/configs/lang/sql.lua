-- INFO: LSP
vim.lsp.enable "sqlls"

-- INFO: LINTING
require("lint").linters_by_ft.sql = { "sqlfluff" }
