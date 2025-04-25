-- INFO: LSP
vim.lsp.enable "neocmake"

-- INFO: LINTING
require("lint").linters_by_ft.cmake = { "cmakelint" }
