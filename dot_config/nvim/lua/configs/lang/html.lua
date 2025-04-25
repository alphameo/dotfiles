-- INFO: LSP
vim.lsp.enable "html"

-- INFO: FORMATTING
require("conform").formatters_by_ft.html = { "prettierd" }

-- INFO: LINTING
require("lint").linters_by_ft.html = { "htmlhint" }
