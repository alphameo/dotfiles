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

-- INFO: LINTING
-- require("lint").linters_by_ft.json = { "jsonlint" }
