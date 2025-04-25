-- INFO: LSP
vim.lsp.enable "marksman"

-- INFO: LINTING
require("lint").linters_by_ft.markdown = { "markdownlint-cli2" }
