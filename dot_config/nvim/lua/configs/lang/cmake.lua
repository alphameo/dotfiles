-- INFO: LSP
vim.lsp.enable "neocmake"

-- INFO: FORMATTING
require("conform").formatters_by_ft.cmake = { "gersemi" }

-- INFO: LINTING
require("lint").linters_by_ft.cmake = { "cmakelint" }
