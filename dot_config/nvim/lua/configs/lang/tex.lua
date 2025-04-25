-- INFO: LSP
vim.lsp.enable "texlab"

-- INFO: FORMATTING
require("conform").formatters_by_ft.tex = { "bibtex-tidy" }

-- INFO: LINTING
-- require("lint").linters_by_ft.tex = { "vale" }
