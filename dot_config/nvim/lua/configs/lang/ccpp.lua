vim.lsp.config("clangd", {
  capabilities = { offsetEncoding = { "utf-16" } },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--all-scopes-completion",
    "--fallback-style=llvm",
  },
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
      fallbackFlags = { "-std=c++20" },
    },
  },
})
vim.lsp.enable "clangd"

