-- INFO: LSP
vim.lsp.enable "html"

-- INFO: LINTING
require("lint").linters_by_ft.html = { "htmlhint" }
