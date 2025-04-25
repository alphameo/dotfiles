vim.lsp.config("kotlin_language_server", {
  settings = {
    kotlin = {
      hints = {
        typeHints = true,
        parameterHints = true,
        chaineHints = true,
      },
    },
  },
})
vim.lsp.enable "kotlin_language_server"
