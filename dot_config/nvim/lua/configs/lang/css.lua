-- INFO: LSP
vim.lsp.enable "cssls"
vim.lsp.enable "css_variables"
vim.lsp.enable "cssmodules_ls"

-- INFO: FORMATTING
require("conform").formatters_by_ft.css = { "prettierd" }

-- INFO: LINTING
-- ISSUE:
-- require("lint").linters_by_ft.css = { "stylelint" }
