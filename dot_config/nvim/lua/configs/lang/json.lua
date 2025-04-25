-- INFO: LSP
vim.lsp.config("jsonls", {
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
    },
  },
})
vim.lsp.enable "jsonls"

-- INFO: FORMATTING
require("conform").formatters_by_ft.json = { "prettierd" }

-- INFO: LINTING
-- require("lint").linters_by_ft.json = { "jsonlint" }
