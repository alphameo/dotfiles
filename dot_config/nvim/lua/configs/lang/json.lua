vim.lsp.config("jsonls", {
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
    },
  },
})
vim.lsp.enable "jsonls"
